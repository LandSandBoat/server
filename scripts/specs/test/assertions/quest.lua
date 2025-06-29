---@meta

-- luacheck: ignore 241
---@class luassert.quest
local quest = {}

quest.has   = quest
quest.no    = quest

---Assert that a quest has a specific status
---@param status xi.questStatus The expected quest status
---@return luassert.quest
function quest.status(status)
end
