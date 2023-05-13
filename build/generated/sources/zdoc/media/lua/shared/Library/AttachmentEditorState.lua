---@class AttachmentEditorState : zombie.gameStates.AttachmentEditorState
---@field public instance AttachmentEditorState
---@field private m_luaEnv EditVehicleState.LuaEnvironment
---@field private bExit boolean
---@field private m_gameUI ArrayList|Unknown
---@field private m_selfUI ArrayList|Unknown
---@field private m_bSuspendUI boolean
---@field private m_table KahluaTable
AttachmentEditorState = {}

---@private
---@return void
function AttachmentEditorState:updateScene() end

---@private
---@return void
function AttachmentEditorState:renderScene() end

---@public
---@return void
function AttachmentEditorState:render() end

---@private
---@return void
function AttachmentEditorState:renderUI() end

---@public
---@param arg0 String
---@param arg1 Object
---@return Object
function AttachmentEditorState:fromLua1(arg0, arg1) end

---@public
---@return void
function AttachmentEditorState:exit() end

---@public
---@return void
function AttachmentEditorState:reenter() end

---@public
---@param arg0 KahluaTable
---@return void
function AttachmentEditorState:setTable(arg0) end

---@private
---@param arg0 String
---@param arg1 ArrayList|Unknown
---@return void
function AttachmentEditorState:writeScript(arg0, arg1) end

---@private
---@return void
function AttachmentEditorState:saveGameUI() end

---@public
---@return AttachmentEditorState
function AttachmentEditorState:checkInstance() end

---@public
---@return GameStateMachine.StateAction
function AttachmentEditorState:update() end

---@private
---@param arg0 String
---@param arg1 ArrayList|Unknown
---@param arg2 ModelScript
---@return void
function AttachmentEditorState:updateScript(arg0, arg1, arg2) end

---@public
---@return void
function AttachmentEditorState:enter() end

---@private
---@param arg0 ModelScript
---@param arg1 String
---@return String
function AttachmentEditorState:modelScriptToText(arg0, arg1) end

---@public
---@return void
function AttachmentEditorState:yield() end

---@public
---@param arg0 String
---@return Object
function AttachmentEditorState:fromLua0(arg0) end

---@private
---@param arg0 String
---@return ArrayList|Unknown
function AttachmentEditorState:readScript(arg0) end

---@private
---@return void
function AttachmentEditorState:restoreGameUI() end
