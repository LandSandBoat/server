-----------------------------------
-- Area: Metalworks
--  NPC: Karst
-- Type: President
-- Involved in Bastok Missions 5-2
-- !pos 106 -21 0 237
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(BASTOK)

    if (currentMission == xi.mission.id.bastok.ON_MY_WAY) and (player:getMissionStatus(player:getNation()) == 0) then
        player:startEvent(765)
    elseif (currentMission == xi.mission.id.bastok.ON_MY_WAY) and (player:getMissionStatus(player:getNation()) == 3) then
        player:startEvent(766)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 765) then
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 766) then
        finishMissionTimeline(player, 1, csid, option)
    end
end

return entity
