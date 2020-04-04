-----------------------------------
-- Area: Heaven's Tower
--  NPC: Kupipi
-- Involved in Mission 2-3
-- Involved in Quest: Riding on the Clouds
-- !pos 2 0.1 30 242
-----------------------------------
local ID = require("scripts/zones/Heavens_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

local TrustMemory = function(player)
    local memories = 0
    if player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_THREE_KINGDOMS) then
        memories = memories + 2
    end
    -- 4 - nothing
    if player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.MOON_READING) then
        memories = memories + 8
    end
    -- 16 - chocobo racing
    --  memories = memories + 16
    return memories
end

function onTrade(player, npc, trade)
    if
        player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_4") == 8 and
        trade:hasItemQty(1127, 1) and -- Kindred seal
        trade:getItemCount() == 1
    then
        player:setCharVar("ridingOnTheClouds_4", 0)
        player:tradeComplete()
        player:addKeyItem(tpz.ki.SPIRITED_STONE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SPIRITED_STONE)
    elseif
        trade:hasItemQty(4365, 1) and -- Rolanberry
        trade:getItemCount() == 1 and
        player:getNation() == tpz.nation.WINDURST and
        player:getRank() >= 2 and
        not player:hasKeyItem(tpz.ki.PORTAL_CHARM)
    then
        if player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.WRITTEN_IN_THE_STARS) then
            player:startEvent(291) -- Qualifies for the reward immediately
        else
            player:startEvent(292) -- Kupipi owes you the portal charm later
        end
    end
end

function onTrigger(player, npc)
    local pNation = player:getNation()
    local currentMission = player:getCurrentMission(pNation)
    local missionStatus = player:getCharVar("MissionStatus")

    local TrustSandoria = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TRUST_SANDORIA)
    local TrustBastok   = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.TRUST_BASTOK)
    local TrustWindurst = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TRUST_WINDURST)
    local WindurstFirstTrust = player:getCharVar("WindurstFirstTrust")
    local KupipiTrustChatFlag = player:getLocalVar("KupipiTrustChatFlag")
    local Rank3 = player:getRank() >= 3 and 1 or 0

    if TrustWindurst == QUEST_ACCEPTED and (TrustSandoria == QUEST_COMPLETED or TrustBastok == QUEST_COMPLETED) then
        player:startEvent(439, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank3)
    elseif TrustWindurst == QUEST_ACCEPTED and WindurstFirstTrust == 0 then
        player:startEvent(435, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank3)
    elseif TrustWindurst == QUEST_ACCEPTED and WindurstFirstTrust == 1 and KupipiTrustChatFlag == 0 then
        player:startEvent(436)
        player:setLocalVar("KupipiTrustChatFlag", 1)
    elseif TrustWindurst == QUEST_ACCEPTED and WindurstFirstTrust == 2 then
        player:startEvent(437)
    elseif TrustWindurst == QUEST_COMPLETED and not player:hasSpell(901) and KupipiTrustChatFlag == 0 then
        player:startEvent(438)
        player:setLocalVar("KupipiTrustChatFlag", 1)
    elseif pNation == tpz.nation.SANDORIA then
        -- San d'Oria Mission 2-3 Part I - Windurst > Bastok
        if currentMission == tpz.mission.id.sandoria.JOURNEY_TO_WINDURST then
            if missionStatus == 4 then
                player:startEvent(238, 1, 1, 1, 1, pNation)
            elseif missionStatus == 5 then
                player:startEvent(240)
            elseif missionStatus == 6 then
                player:startEvent(241)
            end
        -- San d'Oria Mission 2-3 Part II - Bastok > Windurst
        elseif currentMission == tpz.mission.id.sandoria.JOURNEY_TO_WINDURST2 then
            if missionStatus == 7 then
                player:startEvent(242, 1, 1, 1, 1, 0)
            elseif missionStatus == 8 then
                player:startEvent(243)
            elseif missionStatus == 9 then
                player:startEvent(246)
            elseif missionStatus == 10 then
                player:startEvent(247)
            end
        else
            player:startEvent(251)
        end
    elseif pNation == tpz.nation.BASTOK then
        -- Bastok Mission 2-3 Part I - Windurst > San d'Oria
        if currentMission == tpz.mission.id.bastok.THE_EMISSARY_WINDURST then
            if missionStatus == 3 then
                player:startEvent(238, 1, 1, 1, 1, pNation)
            elseif missionStatus <= 5 then
                player:startEvent(240)
            elseif missionStatus == 6 then
                player:startEvent(241)
            end
        -- Bastok Mission 2-3 Part II - San d'Oria > Windurst
        elseif currentMission == tpz.mission.id.bastok.THE_EMISSARY_WINDURST2 then
            if missionStatus == 7 then
                player:startEvent(242, 1, 1, 1, 1, pNation)
            elseif missionStatus == 8 then
                player:startEvent(243)
            elseif missionStatus == 9 then
                player:startEvent(244)
            elseif missionStatus == 10 then
                player:startEvent(245)
            end
        else
            player:startEvent(251)
        end
    elseif pNation == tpz.nation.WINDURST then
        if currentMission == tpz.mission.id.windurst.THE_THREE_KINGDOMS and missionStatus == 0 then
            player:startEvent(95, 0, 0, 0, tpz.ki.LETTER_TO_THE_CONSULS_WINDURST)
        elseif currentMission == tpz.mission.id.windurst.THE_THREE_KINGDOMS and missionStatus == 11 then
            player:startEvent(101, 0, 0, tpz.ki.ADVENTURERS_CERTIFICATE)
        elseif currentMission == tpz.mission.id.windurst.THE_THREE_KINGDOMS then
            player:startEvent(97)
        elseif currentMission == tpz.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT and missionStatus == 0 then
            player:startEvent(103, 0, 0, tpz.ki.STARWAY_STAIRWAY_BAUBLE)
        elseif currentMission == tpz.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT and missionStatus == 1 then
            player:startEvent(104)
        elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and missionStatus == 3 then
            player:startEvent(326)
        elseif player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.WRITTEN_IN_THE_STARS) and player:getCharVar("OwesPortalCharm") == 1 then
            player:startEvent(293) -- Kupipi repays your favor
        elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.MOON_READING and missionStatus >= 3 then
            player:startEvent(400) -- Kupipi in disbelief over player becoming Rank 10
        elseif pNation == tpz.nation.WINDURST and player:getRank() == 10 then
            player:startEvent(408) -- After achieving Windurst Rank 10, Kupipi has more to say
        else
            player:startEvent(251)
        end
    else
        player:startEvent(251)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 238 then
        if player:getNation() == tpz.nation.BASTOK then
            player:setCharVar("MissionStatus", 4)
            player:addKeyItem(tpz.ki.SWORD_OFFERING)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SWORD_OFFERING)
        else
            player:setCharVar("MissionStatus", 5)
            player:addKeyItem(tpz.ki.SHIELD_OFFERING)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SHIELD_OFFERING)
        end
    elseif csid == 244 or csid == 246 then
        player:setCharVar("MissionStatus", 10)
    elseif csid == 242 then
        player:addKeyItem(tpz.ki.DARK_KEY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DARK_KEY)
        player:setCharVar("MissionStatus", 8)
    elseif csid == 95 then
        player:setCharVar("MissionStatus", 1)
        player:addKeyItem(tpz.ki.LETTER_TO_THE_CONSULS_WINDURST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTER_TO_THE_CONSULS_WINDURST)
    elseif csid == 103 then
        player:setCharVar("MissionStatus", 1)
        player:addKeyItem(tpz.ki.STARWAY_STAIRWAY_BAUBLE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.STARWAY_STAIRWAY_BAUBLE)
    elseif csid == 101 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 291 then -- All condition met, grant Portal Charm
        player:tradeComplete()
        player:addKeyItem(tpz.ki.PORTAL_CHARM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PORTAL_CHARM)
    elseif csid == 292 then -- Traded rolanberry, but not all conditions met
        player:tradeComplete()
        player:setCharVar("OwesPortalCharm", 1)
    elseif csid == 293 then -- Traded rolanberry before, and all conditions are now met
        player:setCharVar("OwesPortalCharm", 0)
        player:addKeyItem(tpz.ki.PORTAL_CHARM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PORTAL_CHARM)
    elseif csid == 326 then
        player:setCharVar("MissionStatus", 4)
    elseif csid == 400 then
        player:setCharVar("KupipiDisbelief", 0)
    elseif csid == 408 then
        player:setCharVar("KupipiRankTenText", 1)

    --TRUST
    elseif csid == 435 then
        player:addSpell(898, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 898)
        player:setCharVar("WindurstFirstTrust", 1)
    elseif csid == 437 then
        player:delKeyItem(tpz.ki.GREEN_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.GREEN_INSTITUTE_CARD)
        npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.TRUST_WINDURST, {
            keyItem = tpz.ki.WINDURST_TRUST_PERMIT,
            title = tpz.title.THE_TRUSTWORTHY,
            var = "WindurstFirstTrust" })
        player:messageSpecial(ID.text.CALL_MULTIPLE_ALTER_EGO)
    elseif csid == 439 then
        player:addSpell(898, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 898)
        player:delKeyItem(tpz.ki.GREEN_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.GREEN_INSTITUTE_CARD)
        npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.TRUST_WINDURST, {
            keyItem = tpz.ki.WINDURST_TRUST_PERMIT })
    end
end
