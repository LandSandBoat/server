-----------------------------------
-- Area: Metalworks
--  NPC: Savae E Paleade
-- Involved In Mission: Journey Abroad
-- !pos 23.724 -17.39 -43.360 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.SANDORIA) ~= xi.mission.id.sandoria.NONE then
        player:startEvent(208)
    else
        player:startEvent(200)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
