-----------------------------------
-- Area: Metalworks
--  NPC: Savae E Paleade
-- Involved In Mission: Journey Abroad
-- !pos 23.724 -17.39 -43.360 237
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.SANDORIA) ~= xi.mission.id.sandoria.NONE then
        player:startEvent(208)
    else
        player:startEvent(200)
    end
end

return entity
