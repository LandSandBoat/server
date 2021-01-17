-----------------------------------
-- Area: Heaven's Tower
--  NPC: Vestal Chamber (chamber of the Star Sibyl)
-- !pos 0.1 -49 37 242
-----------------------------------
local ID = require("scripts/zones/Heavens_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(WINDURST)
    local missionStatus = player:getCharVar("MissionStatus")

    if currentMission == tpz.mission.id.windurst.A_NEW_JOURNEY and missionStatus == 0 then
        player:startEvent(153)
    elseif player:hasKeyItem(tpz.ki.MESSAGE_TO_JEUNO_WINDURST) then
        player:startEvent(166)
    elseif
        player:getRank() == 5 and
        currentMission == tpz.mission.id.windurst.NONE and
        not player:hasCompletedMission(tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_FINAL_SEAL)
    then
        player:startEvent(190)
    elseif player:hasKeyItem(tpz.ki.BURNT_SEAL) then
        player:startEvent(192)
    elseif currentMission == tpz.mission.id.windurst.THE_SHADOW_AWAITS and missionStatus == 0 then
        player:startEvent(214)
    elseif currentMission == tpz.mission.id.windurst.THE_SHADOW_AWAITS and player:hasKeyItem(tpz.ki.SHADOW_FRAGMENT) then
        player:startEvent(216)
    elseif currentMission == tpz.mission.id.windurst.SAINTLY_INVITATION and missionStatus == 0 then
        player:startEvent(310)
    elseif currentMission == tpz.mission.id.windurst.SAINTLY_INVITATION and missionStatus == 3 then
        player:startEvent(312)
    elseif currentMission == tpz.mission.id.windurst.DOLL_OF_THE_DEAD and missionStatus == 2 then
        player:startEvent(362)
    elseif currentMission == tpz.mission.id.windurst.MOON_READING and missionStatus == 0 then
        player:startEvent(384)
    elseif
        currentMission == tpz.mission.id.windurst.MOON_READING and
        missionStatus == 1 and
        player:hasKeyItem(tpz.ki.ANCIENT_VERSE_OF_ROMAEVE) and
        player:hasKeyItem(tpz.ki.ANCIENT_VERSE_OF_ALTEPA) and player:hasKeyItem(tpz.ki.ANCIENT_VERSE_OF_UGGALEPIH)
    then
        player:startEvent(385)
    elseif currentMission == tpz.mission.id.windurst.MOON_READING and missionStatus == 3 then
        player:startEvent(386)
    elseif currentMission == tpz.mission.id.windurst.MOON_READING and missionStatus == 4 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 183)
        else
            player:startEvent(407)
        end
    else
        player:startEvent(154)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 153 then
        player:setCharVar("MissionStatus", 1)
        player:delKeyItem(tpz.ki.STAR_CRESTED_SUMMONS)
        player:addKeyItem(tpz.ki.LETTER_TO_THE_AMBASSADOR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTER_TO_THE_AMBASSADOR)
    elseif csid == 166 or csid == 190 then
        if option == 0 then
            player:addMission(tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_FINAL_SEAL)
            player:addKeyItem(tpz.ki.NEW_FEIYIN_SEAL)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.NEW_FEIYIN_SEAL)
            player:setCharVar("MissionStatus", 10)
        end
        player:delKeyItem(tpz.ki.MESSAGE_TO_JEUNO_WINDURST)
    elseif csid == 214 then
        player:setCharVar("MissionStatus", 2)
        player:delKeyItem(tpz.ki.STAR_CRESTED_SUMMONS)
        player:addTitle(tpz.title.STARORDAINED_WARRIOR)
    elseif csid == 310 then
        player:setCharVar("MissionStatus", 1)
        player:addTitle(tpz.title.HERO_ON_BEHALF_OF_WINDURST)
        player:addKeyItem(tpz.ki.HOLY_ONES_INVITATION)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HOLY_ONES_INVITATION)
    elseif csid == 312 then
        finishMissionTimeline(player, 3, csid, option)
    elseif csid == 192 or csid == 216 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 362 then
        player:setCharVar("MissionStatus", 3)
    elseif csid == 384 then
        player:setCharVar("MissionStatus", 1)
    elseif csid == 385 then
        player:setCharVar("MissionStatus", 2)
    elseif csid == 386 then
        player:setCharVar("MissionStatus", 4)
    elseif csid == 407 then
        player:setPos(0, -16.750, 130, 64, 239)
    end
end

return entity
