-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Yahsra
-- Type: Assault Mission Giver
-- !pos 120.967 0.161 -44.002 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.onMissionGiverTrigger(player, npc, 273, xi.assault.assaultArea.LEUJAOAM_SANCTUM)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onMissionGiverUpdate(player, csid, option, npc, 273, xi.assault.assaultArea.LEUJAOAM_SANCTUM)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onMissionGiverEventFinish(player, csid, option, npc, 273, xi.assault.assaultArea.LEUJAOAM_SANCTUM)
end

return entity
