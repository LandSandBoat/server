-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Lageegee
-- Type: Assault Mission Giver
-- !pos 120.808 0.161 -30.435
-----------------------------------
---@type TNpcEntity
local entity = {}

local assaultArea = xi.assault.assaultArea.PERIQIA
local eventOffset = 276

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
