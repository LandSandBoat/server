-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Famad
-- Type: Assault Mission Giver
-- !pos 134.098 0.161 -43.759 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.onMissionGiverTrigger(player, npc, 275, xi.assault.assaultArea.LEBROS_CAVERN)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onMissionGiverUpdate(player, csid, option, npc, 275, xi.assault.assaultArea.LEBROS_CAVERN)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onMissionGiverEventFinish(player, csid, option, npc, 275, xi.assault.assaultArea.LEBROS_CAVERN)
end

return entity
