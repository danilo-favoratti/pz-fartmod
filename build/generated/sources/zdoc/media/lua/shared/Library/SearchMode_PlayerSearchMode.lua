---@class SearchMode.PlayerSearchMode : zombie.iso.SearchMode.PlayerSearchMode
---@field private plrIndex int
---@field private parent SearchMode
---@field private override boolean
---@field private enabled boolean
---@field private radius SearchMode.SearchModeFloat
---@field private gradientWidth SearchMode.SearchModeFloat
---@field private blur SearchMode.SearchModeFloat
---@field private desat SearchMode.SearchModeFloat
---@field private darkness SearchMode.SearchModeFloat
---@field private timer float
---@field private doFadeOut boolean
---@field private doFadeIn boolean
SearchMode_PlayerSearchMode = {}

---@private
---@return boolean
function SearchMode_PlayerSearchMode:isPlayerExterior() end

---@public
---@return SearchMode.SearchModeFloat
function SearchMode_PlayerSearchMode:getRadius() end

---@public
---@return SearchMode.SearchModeFloat
function SearchMode_PlayerSearchMode:getBlur() end

---@public
---@return float
function SearchMode_PlayerSearchMode:getShaderBlur() end

---@public
---@return float
function SearchMode_PlayerSearchMode:getShaderGradientWidth() end

---@public
---@return SearchMode.SearchModeFloat
function SearchMode_PlayerSearchMode:getGradientWidth() end

---@public
---@return float
function SearchMode_PlayerSearchMode:getShaderDarkness() end

---@public
---@return SearchMode.SearchModeFloat
function SearchMode_PlayerSearchMode:getDesat() end

---@public
---@return boolean
function SearchMode_PlayerSearchMode:isShaderEnabled() end

---@private
---@return void
function SearchMode_PlayerSearchMode:update() end

---@public
---@return SearchMode.SearchModeFloat
function SearchMode_PlayerSearchMode:getDarkness() end

---@public
---@return float
function SearchMode_PlayerSearchMode:getShaderDesat() end

---@public
---@return float
function SearchMode_PlayerSearchMode:getShaderRadius() end
