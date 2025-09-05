-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Yahsra
-- Type: Assault Mission Giver
-- !pos 120.967 0.161 -44.002 50
-----------------------------------
---@type TNpcEntity
local entity = {}

local assaultArea = xi.assault.assaultArea.LEUJAOAM_SANCTUM
local eventOffset = 273

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
