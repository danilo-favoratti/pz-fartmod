TNTMod = TNTMod

local lactoseIntolerantTrait = "lactose_intolerant";
local TRAIT_POINTS = -4;

local UNHAPPINESS_IMPROVE_WHEN_FART = 20;
local UNHAPPINESS_WORSEN_BY_UPDATE = 0.00003;
local UNHAPPINESS_WORSEN_BY_UPDATE_WITH_TRAIT = 0.0001;

local RANDOM_FART = 0;
local DEATH_FART = 1;
local INIT_FART_PER_HOUR = 0.2;
local chanceToFartPerHour = INIT_FART_PER_HOUR;

local function initTraits()
    --general traits
    local lactoseIntolerant = TraitFactory.addTrait(lactoseIntolerantTrait, getText("UI_trait_lactose_intolerant"), TRAIT_POINTS, getText("UI_traitdesc_lactose_intolerant"), false, false);
end

local printLog = function (message)
    if (isDebugEnabled()) then
        print(message);
    end
end

local playWorldSound = function(player, sound, soundRadius, volume)
    -- zombies and world can hear
    player:getEmitter():playSound(sound);

    addSound(player,
            player:getX(),
            player:getY(),
            player:getZ(),
            soundRadius,
            volume);
end

local playFartSound = function(player, fartType)
    if fartType == 0 then
        fartType = ZombRand(3); -- choose which sound randomly
    end

    if fartType == 1 then
        printLog("Fart 1 played");
        playWorldSound(player, "Fart1", 15, 7);
    elseif fartType == 2 then
        printLog("Fart 2 played");
        playWorldSound(player, "Fart2", 10, 7);
    elseif fartType == 3 then
        printLog("Fart 3 played");
        playWorldSound(player, "Fart3", 10, 5);
    end
end

local updateChanceToFart = function (player)
    if player:HasTrait(lactoseIntolerantTrait) then
        chanceToFartPerHour = chanceToFartPerHour + UNHAPPINESS_WORSEN_BY_UPDATE;
    else
        chanceToFartPerHour = chanceToFartPerHour + UNHAPPINESS_WORSEN_BY_UPDATE_WITH_TRAIT;
    end
    printLog("chanceToFartPerHour: ".. tostring(chanceToFartPerHour));
end

local function updateUnhappiness ()
    local activePlayersNum = getNumActivePlayers() - 1;
    for playerIndex = 0, activePlayersNum do
        local player = getSpecificPlayer(playerIndex);
        local bodyDamage = player:getBodyDamage();
        bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() + UNHAPPINESS_WORSEN_BY_UPDATE);
        if bodyDamage:getUnhappynessLevel() > 100 then
            bodyDamage:setUnhappynessLevel(100);
        end
        printLog("Unhappiness: ".. bodyDamage:getUnhappynessLevel());
    end
end

local onPlayerUpdate = function (player)
    updateUnhappiness();
    updateChanceToFart(player);
end

local fart = function (fartType)
    local activePlayersNum = getNumActivePlayers() - 1;
    for playerIndex = 0, activePlayersNum do
        local player = getSpecificPlayer(playerIndex);
        chanceToFartPerHour = INIT_FART_PER_HOUR; -- go back to initial level
        playFartSound(player, fartType);
        local bodyDamage = player:getBodyDamage();
        bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() - UNHAPPINESS_IMPROVE_WHEN_FART);
        if bodyDamage:getUnhappynessLevel() < 0 then
            bodyDamage:setUnhappynessLevel(0);
        end
    end
end

local fartByChance = function (chance)
    local fartRand = ZombRand(100);
    if fartRand < 100 * chanceToFartPerHour / chance then
        fart(RANDOM_FART);
    end
end

local function tntEveryTenMinutes()
    fartByChance(6); -- 1 hour = 60 minutes
end

local onKeyPressed = function(key)
    if key == Keyboard.KEY_E then
        if isAltKeyDown() then
            if (isDebugEnabled()) then
                fart(RANDOM_FART);
            else
                fartByChance(1);
            end
        end
    end
end

local function deathFart()
    fart(DEATH_FART);
end

Events.OnGameBoot.Add(initTraits);

Events.OnPlayerDeath.Add(deathFart);
Events.OnKeyPressed.Add(onKeyPressed);
Events.OnPlayerUpdate.Add(onPlayerUpdate);
Events.EveryTenMinutes.Add(tntEveryTenMinutes);

