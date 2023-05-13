---@class RBOffice : zombie.randomizedWorld.randomizedBuilding.RBOffice
RBOffice = {}

---@public
---@param arg0 IsoGridSquare
---@return boolean
function RBOffice:roomValid(arg0) end

---@public
---@param arg0 BuildingDef
---@return void
function RBOffice:randomizeBuilding(arg0) end

---@public
---@param arg0 BuildingDef
---@param arg1 boolean
---@return boolean
function RBOffice:isValid(arg0, arg1) end
