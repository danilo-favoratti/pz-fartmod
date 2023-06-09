--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************
local MAX_TOTAL = 3
local MAX_BASE = MAX_TOTAL
local MAX_SPICE = MAX_TOTAL
local MAX_LENGTH = 28

require "TimedActions/ISBaseTimedAction"

---@class ISAddItemInRecipe : ISBaseTimedAction
ISAddItemInRecipe = ISBaseTimedAction:derive("ISAddItemInRecipe");

function ISAddItemInRecipe:isValid()
	return self.character:getInventory():contains(self.baseItem) and self.recipe:getItemsCanBeUse(self.character, self.baseItem, nil):contains(self.usedItem)
end

function ISAddItemInRecipe:update()
    self.baseItem:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISAddItemInRecipe:start()
    self.baseItem:setJobType(getText("IGUI_JobType_AddingIngredient", self.usedItem:getDisplayName(), self.baseItem:getDisplayName()));
    local soundName = self.recipe:getAddIngredientSound() or "AddItemInRecipe"
    self.sound = self.character:getEmitter():playSoundImpl(soundName, nil)
end

function ISAddItemInRecipe:stop()
    self.baseItem:setJobDelta(0.0);
    if self.sound and self.sound ~= 0 then
        self.character:getEmitter():stopOrTriggerSound(self.sound)
    end
    ISBaseTimedAction.stop(self);
end

function ISAddItemInRecipe:perform()    
    self.baseItem:setJobDelta(0.0);
    self.character:removeFromHands(self.baseItem)

    if self.sound and self.sound ~= 0 then
        self.character:getEmitter():stopOrTriggerSound(self.sound)
    end

    self.baseItem = self.recipe:addItem(self.baseItem, self.usedItem, self.character);
    
    ISAddItemInRecipe.checkName(self.baseItem, self.recipe);
	
	if not self.baseItem:isCustomName() and self.baseItem:getFoodType() == "Beer" then
		 baseItem:setName(getText("ContextMenu_FoodType_Beer"))
	end

    ISAddItemInRecipe.checkTemperature(self.baseItem, self.usedItem, self.recipe);

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

-- update the item temperature
ISAddItemInRecipe.checkTemperature = function(baseItem, usedItem, recipe)
    if baseItem and instanceof(baseItem, "Food") and usedItem and instanceof(usedItem, "Food") then
        --average the temperatures (adding cooked food to a recipe raises the heat)
        baseItem:setHeat((baseItem:getHeat() + usedItem:getHeat()) / 2);
    end;
end

-- Generate the recipe's name
ISAddItemInRecipe.checkName = function(baseItem, recipe)
    local foodTypeList = {};
    local finalName = "";
    local spicesName = "";
	local name = "";
    local count = 0;
    if not baseItem:getExtraItems() and not baseItem:getSpices() then
        return;
    end
    if instanceof(baseItem, "Food") and not baseItem:isCustomName() then -- Don't do anything if it's custom (unique recipe or changed by the player)
		if baseItem:getExtraItems() then 
			for i=0,baseItem:getExtraItems():size()-1 do
				for i,v in pairs(foodTypeList) do
					if v ~= "" then count = count + 1 end
				end
				local food = InventoryItemFactory.CreateItem(baseItem:getExtraItems():get(i));
				local name = food:getEvolvedRecipeName() or food:getDisplayName();
				if instanceof(food, "Food") then
					if food:getFoodType() == "NoExplicit" or not food:getFoodType() then -- no explicit appear only if there's no other ingredient inside the recipe
						if count == 0 then
							foodTypeList["NoExplicit"] = food:getDisplayName();
						end
					else
						foodTypeList["NoExplicit"] = "";
						if not foodTypeList[getText("ContextMenu_FoodType_" .. food:getFoodType())] then -- first we show the name of food, if there's more than 1 time this type of food, we show the food type
							foodTypeList[getText("ContextMenu_FoodType_" .. food:getFoodType())] = name;
						elseif foodTypeList[getText("ContextMenu_FoodType_" .. food:getFoodType())] ~= food:getDisplayName() then -- only if the name is different (you can add 4x tomato, it'll stay as Tomato and not "vegetables")
							foodTypeList[getText("ContextMenu_FoodType_" .. food:getFoodType())] = getText("ContextMenu_FoodType_" .. food:getFoodType());
						end
					end
				end
			end
		end		
        count = 0;
        for i,v in pairs(foodTypeList) do
            if v ~= "" then count = count + 1 end
        end
        if count > MAX_BASE then -- avoid too big name
			count = 0
			name = getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName())
			baseItem:setName(getText(name))
        else -- do the name
			local index = 0
            for i,v in pairs(foodTypeList) do
                if v ~= "" and (not ((v == "Fruit" or v == "Fruits") and baseItem:getType() == "FruitSalad") ) then -- kludge for fruit salads until better naming is implemented
                    if finalName ~= "" then
						if index == count then
							finalName = finalName .. " " .. getText("ContextMenu_EvolvedRecipe_and") .. " ";
						else
							finalName = finalName .. getText("ContextMenu_EvolvedRecipe_comma") .. " ";
						end
                    end
                    finalName = finalName .. v;
                end
				index = index + 1
            end
			name = getText("ContextMenu_EvolvedRecipe_RecipeName", finalName , getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName()))
			baseItem:setName(getText(name))
        end
    end
    if count > MAX_TOTAL then -- if there's the maximum amount of food elements, don't wast time on spices
		ISInventoryPage.dirtyUI();
		return
	end
	local previousCount = count
	if baseItem:getSpices() then 		
		count = 0;
		foodTypeList = {};
		for i=0,baseItem:getSpices():size()-1 do
			for i,v in pairs(foodTypeList) do
				if v ~= "" then count = count + 1 end
			end
			local food = InventoryItemFactory.CreateItem(baseItem:getSpices():get(i));
			local name = food:getEvolvedRecipeName() or food:getDisplayName();
			if instanceof(food, "Food") and not food:hasTag("MinorIngredient") then
				if food:getFoodType() == "NoExplicit" or not food:getFoodType() then -- no explicit appear only if there's no other ingredient inside the recipe
					if count == 0 then
						foodTypeList["NoExplicit"] = food:getDisplayName();
					end
				else
					foodTypeList["NoExplicit"] = "";
					if not foodTypeList[getText("ContextMenu_FoodType_" .. food:getFoodType())] then -- first we show the name of food, if there's more than 1 time this type of food, we show the food type
						foodTypeList[getText("ContextMenu_FoodType_" .. food:getFoodType())] = name;
					elseif foodTypeList[getText("ContextMenu_FoodType_" .. food:getFoodType())] ~= food:getDisplayName() then -- only if the name is different (you can add 4x tomato, it'll stay as Tomato and not "vegetables")
						foodTypeList[getText("ContextMenu_FoodType_" .. food:getFoodType())] = getText("ContextMenu_FoodType_" .. food:getFoodType());
					end
				end
			end
		end
		count = 0;
        for i,v in pairs(foodTypeList) do
            if v ~= "" then count = count + 1 end
        end
        if (count + previousCount ) <= MAX_BASE then -- avoid too big name
			local index = 0
            for i,v in pairs(foodTypeList) do
                if v ~= "" and (not ((v == "Fruit" or v == "Fruits") and baseItem:getType() == "FruitSalad") ) then -- kludge for fruit salads until better naming is implemented
                    if spicesName ~= "" then
						if index == count then
							spicesName = spicesName .. " " .. getText("ContextMenu_EvolvedRecipe_and") .. " ";
						else
							spicesName = spicesName .. getText("ContextMenu_EvolvedRecipe_comma") .. " ";
						end
                    end
                    spicesName = spicesName .. v;
                end
				index = index + 1
            end
			if spicesName:len() > 0 and baseItem:getExtraItems() and baseItem:getExtraItems():size() > 0 then
				name = getText("ContextMenu_EvolvedRecipe_RecipeNameNew", finalName , getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName()) , getText("ContextMenu_EvolvedRecipe_with"), spicesName)
				-- name = getText(getText(name) .. " " .. getText("ContextMenu_EvolvedRecipe_with") .. " " .. getText(spicesName))
				baseItem:setName(getText(name));
			elseif spicesName:len() > 0 then
				--name = getText("ContextMenu_EvolvedRecipe_RecipeNameNew2", getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName()) , getText("ContextMenu_EvolvedRecipe_with"), spicesName)
				name = getText("ContextMenu_EvolvedRecipe_RecipeName", spicesName , getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName()))
				baseItem:setName(getText(name));
			end
        end
	end
    ISInventoryPage.dirtyUI();
end

function ISAddItemInRecipe:new(character, recipe, baseItem, usedItem, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.recipe = recipe;
    o.baseItem = baseItem;
    o.usedItem = usedItem;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = 100 - (character:getPerkLevel(Perks.Cooking) * 2.5);
    if character:isTimedActionInstant() then
        o.maxTime = 1;
    end
    o.jobType = getText("IGUI_JobType_AddingIngredient", usedItem:getDisplayName(), baseItem:getDisplayName());
	return o;
end
