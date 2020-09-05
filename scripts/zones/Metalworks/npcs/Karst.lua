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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local currentMission = player:getCurrentMission(BASTOK)

    if (currentMission == tpz.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS and player:getCharVar("MissionStatus") == 0) then
        player:startEvent(602)
    elseif (currentMission == tpz.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS and player:hasKeyItem(tpz.ki.SHADOW_FRAGMENT)) then
        player:startEvent(603)
    elseif (currentMission == tpz.mission.id.bastok.ON_MY_WAY) and (player:getCharVar("MissionStatus") == 0) then
        player:startEvent(765)
    elseif (currentMission == tpz.mission.id.bastok.ON_MY_WAY) and (player:getCharVar("MissionStatus") == 3) then
        player:startEvent(766)
    else
        player:startEvent(601)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 602) then
        player:setCharVar("MissionStatus", 2)
    elseif (csid == 765) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 766 or csid == 603) then
        finishMissionTimeline(player, 1, csid, option)
    end
end
