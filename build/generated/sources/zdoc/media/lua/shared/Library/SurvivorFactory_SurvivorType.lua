---@class SurvivorFactory.SurvivorType : zombie.characters.SurvivorFactory.SurvivorType
---@field public Friendly SurvivorFactory.SurvivorType
---@field public Neutral SurvivorFactory.SurvivorType
---@field public Aggressive SurvivorFactory.SurvivorType
SurvivorFactory_SurvivorType = {}

---@public
---@param arg0 String
---@return SurvivorFactory.SurvivorType
function SurvivorFactory_SurvivorType:valueOf(arg0) end

---@public
---@return SurvivorFactory.SurvivorType[]
function SurvivorFactory_SurvivorType:values() end
