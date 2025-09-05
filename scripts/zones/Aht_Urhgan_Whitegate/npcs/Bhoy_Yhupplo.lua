-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Bhoy Yhupplo
-- Type: Assault Mission Giver
-- !pos 127.474 0.161 -30.418 50
-----------------------------------
---@type TNpcEntity
local entity = {}

local assaultArea = xi.assault.assaultArea.ILRUSI_ATOLL
local eventOffset = 277

entity.onTrigger = function(player, npc)
    xi.assault.onMissionGiverTrigger(player, npc, eventOffset, assaultArea)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onMissionGiverUpdate(player, csid, option, npc, assaultArea)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onMissionGiverEventFinish(player, csid, option, npc, eventOffset, assaultArea)
end

return entity
