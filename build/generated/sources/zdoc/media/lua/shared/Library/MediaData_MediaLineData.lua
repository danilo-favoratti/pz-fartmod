---@class MediaData.MediaLineData : zombie.radio.media.MediaData.MediaLineData
---@field private text String
---@field private color Color
---@field private codes String
MediaData_MediaLineData = {}

---@public
---@return Color
function MediaData_MediaLineData:getColor() end

---@public
---@return String
function MediaData_MediaLineData:getTranslatedText() end

---@public
---@return String
function MediaData_MediaLineData:getCodes() end

---@public
---@return String
function MediaData_MediaLineData:getTextGuid() end

---@public
---@return float
function MediaData_MediaLineData:getR() end

---@public
---@return float
function MediaData_MediaLineData:getB() end

---@public
---@return float
function MediaData_MediaLineData:getG() end
