-----------------------------------
-- Area: Pso'Xja
--  NPC: Stone Gate
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR) or
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
    then
        if player:getZPos() < 318 then
            player:startEvent(69)
        else
            player:startEvent(70)
        end
    else
        player:messageSpecial(ID.text.DOOR_LOCKED)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
