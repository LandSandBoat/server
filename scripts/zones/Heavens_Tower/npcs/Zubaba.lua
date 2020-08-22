-----------------------------------
-- Area: Heavens Tower
--  NPC: Zubaba
-- Involved in Mission 3-2
-- !pos 15 -27 18 242
-- Note: Includes Topaz modifications which may be subject to Topaz license
-----------------------------------
local ID = require("scripts/zones/Heavens_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
    local currentMission = player:getCurrentMission(WINDURST)
    local nextMissionFinished = player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.A_NEW_JOURNEY)

    if currentMission == tpz.mission.id.windurst.WRITTEN_IN_THE_STARS and player:getCharVar("MissionStatus") == 3 then
        if trade:hasItemQty(16447, 3) and trade:getItemCount() == 3 then -- Trade Rusty Dagger
            player:tradeComplete()
            player:startEvent(151)
        end
    end
end

function onTrigger(player, npc)
    local currentMission = player:getCurrentMission(WINDURST)
    local missionStatus = player:getCharVar("MissionStatus")
    local nextMissionFinished = player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.A_NEW_JOURNEY)
    local starsMissionFinished = player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.WRITTEN_IN_THE_STARS)

    if currentMission == tpz.mission.id.windurst.WRITTEN_IN_THE_STARS and
	   not nextMissionFinished and not starsMissionFinished then
        if missionStatus == 0 then
            player:startEvent(121)
        elseif missionStatus == 1 then
            player:startEvent(122)
        elseif missionStatus == 2 then
            player:startEvent(135)
        end
    elseif
        currentMission == tpz.mission.id.windurst.WRITTEN_IN_THE_STARS and
        (nextMissionFinished or starsMissionFinished)
    then
        if missionStatus == 0 then
            player:startEvent(257, 0, 16447) -- Rusty Dagger
        elseif missionStatus == 3 then
            player:startEvent(150, 0, 16447)
        end
    elseif player:hasKeyItem(tpz.ki.STAR_CRESTED_SUMMONS) then
        player:startEvent(157)
    elseif currentMission == tpz.mission.id.windurst.THE_SHADOW_AWAITS and player:hasKeyItem(tpz.ki.SHADOW_FRAGMENT) then
        player:startEvent(194) -- her reaction after 5-1.
    elseif
        player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.MOON_READING and
        (missionStatus >= 3 or player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.MOON_READING))
    then
        player:startEvent(387)
    else
        player:startEvent(56)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 121 then
        player:addKeyItem(tpz.ki.CHARM_OF_LIGHT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CHARM_OF_LIGHT)
        player:setCharVar("MissionStatus", 1)
    elseif csid == 149 or csid == 257 then
        player:setCharVar("MissionStatus", 3)
    elseif csid == 135 or csid == 151 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 387 then
        player:setCharVar("WindurstSecured", 0)
    end
end
