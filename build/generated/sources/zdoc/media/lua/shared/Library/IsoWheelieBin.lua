---@class IsoWheelieBin : zombie.iso.objects.IsoWheelieBin
---@field velx float
---@field vely float
IsoWheelieBin = {}

---@public
---@param arg0 float
---@param arg1 float
---@return float
function IsoWheelieBin:getWeight(arg0, arg1) end

---@public
---@return void
function IsoWheelieBin:update() end

---@public
---@return String
function IsoWheelieBin:getObjectName() end
