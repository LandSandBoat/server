-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Lageegee
-- Type: Assault Mission Giver
-- !pos 120.808 0.161 -30.435
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.onMissionGiverTrigger(player, npc, 276, xi.assault.assaultArea.PERIQIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onMissionGiverUpdate(player, csid, option, npc, 276, xi.assault.assaultArea.PERIQIA)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onMissionGiverEventFinish(player, csid, option, npc, 276, xi.assault.assaultArea.PERIQIA)
end

return entity
