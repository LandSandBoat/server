-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Famad
-- Type: Assault Mission Giver
-- !pos 134.098 0.161 -43.759 50
-----------------------------------
---@type TNpcEntity
local entity = {}

local assaultArea = xi.assault.assaultArea.LEBROS_CAVERN
local eventOffset = 275

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
