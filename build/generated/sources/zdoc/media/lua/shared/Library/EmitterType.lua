---@class EmitterType : fmod.fmod.EmitterType
---@field public Footstep EmitterType
---@field public Voice EmitterType
---@field public Extra EmitterType
EmitterType = {}

---@public
---@param arg0 String
---@return EmitterType
function EmitterType:valueOf(arg0) end

---@public
---@return EmitterType[]
function EmitterType:values() end
