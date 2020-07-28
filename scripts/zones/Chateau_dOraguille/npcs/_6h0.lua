-----------------------------------
-- Area: Chateau d'Oraguille
-- Door: Prince Royal's
-- Finishes Quest: A Boy's Dream, Under Oath
-- Involved in Missions: 3-1, 5-2, 8-2
-- !pos -38 -3 73 233
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
-----------------------------------

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)

    local currentMission = player:getCurrentMission(SANDORIA)
    local missionStatus = player:getCharVar("MissionStatus")
    local infiltrateDavoi = player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.INFILTRATE_DAVOI)

    if (player:getCharVar("aBoysDreamCS") == 8) then
        player:startEvent(88)
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_BOY_S_DREAM) == QUEST_COMPLETED and player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.UNDER_OATH) == QUEST_AVAILABLE and player:getMainJob() == tpz.job.PLD) then
        player:startEvent(90)
    elseif (player:getCharVar("UnderOathCS") == 8) then
        player:startEvent(89)
    elseif (currentMission == tpz.mission.id.sandoria.INFILTRATE_DAVOI and infiltrateDavoi == false and missionStatus == 0) then
        player:startEvent(553, 0, tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
    elseif (currentMission == tpz.mission.id.sandoria.INFILTRATE_DAVOI and missionStatus == 4) then
        player:startEvent(554, 0, tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
    elseif (currentMission == tpz.mission.id.sandoria.THE_SHADOW_LORD and missionStatus == 1) then
        player:startEvent(547)
    elseif currentMission == tpz.mission.id.sandoria.RANPERRE_S_FINAL_REST and missionStatus == 0 then
        player:startEvent(81)
    elseif currentMission == tpz.mission.id.sandoria.RANPERRE_S_FINAL_REST and missionStatus == 5 then
        player:startEvent(21)
    elseif currentMission == tpz.mission.id.sandoria.RANPERRE_S_FINAL_REST and missionStatus == 7 then
        player:startEvent(79) -- Optional 6-2 CS
    elseif (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.LIGHTBRINGER) and player:getRank() == 9 and player:getCharVar("Cutscenes_8-2") == 0) then
        player:startEvent(63)
    else
        player:startEvent(522)
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 553) then
        player:setCharVar("MissionStatus", 2)
    elseif (csid == 547) then
        player:setCharVar("MissionStatus", 2)
    elseif (csid == 554) then
        finishMissionTimeline(player, 3, csid, option)
    elseif (csid == 88) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14095)
        else
            if (player:getMainJob() == tpz.job.PLD) then
                player:addQuest(SANDORIA, tpz.quest.id.sandoria.UNDER_OATH)
            end
            player:delKeyItem(tpz.ki.KNIGHTS_BOOTS)
            player:addItem(14095)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14095) -- Gallant Leggings
            player:setCharVar("aBoysDreamCS", 0)
            player:addFame(SANDORIA, 40)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.A_BOY_S_DREAM)
        end
    elseif (csid == 90 and option ==1) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.UNDER_OATH)
        player:setCharVar("UnderOathCS", 0)
    elseif (csid == 89) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12644)
        else
            player:addItem(12644)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12644) -- Gallant Surcoat
            player:setCharVar("UnderOathCS", 9)
            player:addFame(SANDORIA, 60)
            player:setTitle(tpz.title.PARAGON_OF_PALADIN_EXCELLENCE)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.UNDER_OATH)
        end
    elseif (csid == 81) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 21) then
        player:setCharVar("MissionStatus", 6)
    elseif (csid == 63) then
        player:setCharVar("Cutscenes_8-2", 1)
    end

end
