-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arnau
-- Involved in Mission: Save the Children
-- !pos 148 0 139 231
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("EMERALD_WATERS_Status") == 2) then
        player:startEvent(51) --COP event
    elseif (player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.SAVE_THE_CHILDREN and player:getMissionStatus(player:getNation()) < 2) then
        player:startEvent(693)
    elseif (player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN) and player:getCharVar("OptionalCSforSTC") == 1) then
        player:startEvent(694)
    else
        player:startEvent(20)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 51) then
        player:setCharVar("EMERALD_WATERS_Status", 3)
    elseif (csid == 693) then
        player:setMissionStatus(player:getNation(), 2)
    elseif (csid == 694) then
        player:setCharVar("OptionalCSforSTC", 0)
    end
end

return entity
