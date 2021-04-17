-----------------------------------
-- Area: Metalworks
--  NPC: Naji
-- Involved in Quests: The doorman (finish), Riding on the Clouds
-- Involved in Mission: Bastok 6-2
-- !pos 64 -14 -4 237
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/titles");
require("scripts/globals/quests");
require("scripts/globals/missions");
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Metalworks/IDs");
-----------------------------------
local entity = {}

local TrustMemory = function(player)
    local memories = 0
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY) then
        memories = memories + 2
    end
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN) then
        memories = memories + 4
    end
    if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 8
    end
    -- 16 - Chocobo racing
    --  memories = memories + 16
    return memories
end

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_2") == 6) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:tradeComplete()
            player:addKeyItem(xi.ki.SMILING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SMILING_STONE)
        end
    end

end

entity.onTrigger = function(player, npc)
    local TrustSandoria = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
    local TrustBastok = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)
    local TrustWindurst = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)
    local BastokFirstTrust = player:getCharVar("BastokFirstTrust")
    local NajiTrustChatFlag = player:getLocalVar("NajiTrustChatFlag")
    local Rank3 = player:getRank() >= 3 and 1 or 0

    if TrustBastok == QUEST_ACCEPTED and (TrustSandoria == QUEST_COMPLETED or TrustWindurst == QUEST_COMPLETED) then
        player:startEvent(984, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank3)
    elseif TrustBastok == QUEST_ACCEPTED and BastokFirstTrust == 0 then
        player:startEvent(980, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank3)
    elseif TrustBastok == QUEST_ACCEPTED and BastokFirstTrust == 1 and NajiTrustChatFlag == 0 then
        player:startEvent(981)
        player:setLocalVar("NajiTrustChatFlag", 1)
    elseif TrustBastok == QUEST_ACCEPTED and BastokFirstTrust == 2 then
        player:startEvent(982)
    elseif TrustBastok == QUEST_COMPLETED and not player:hasSpell(900) and NajiTrustChatFlag == 0 then
        player:startEvent(983, 0, 0, 0, 0, 0, 0, 0, Rank3)
        player:setLocalVar("NajiTrustChatFlag", 1)

    elseif (player:hasKeyItem(xi.ki.YASINS_SWORD)) then -- The Doorman, WAR AF1
        player:startEvent(750);
    elseif (player:getCurrentMission(BASTOK) ~= xi.mission.id.bastok.NONE) then
        local currentMission = player:getCurrentMission(BASTOK)

        if (currentMission == xi.mission.id.bastok.THE_ZERUHN_REPORT and player:hasKeyItem(xi.ki.ZERUHN_REPORT)) then
            if (player:seenKeyItem(xi.ki.ZERUHN_REPORT)) then
                player:startEvent(710, 0)
            else
                player:startEvent(710, 1)
            end
        elseif (currentMission == xi.mission.id.bastok.THE_CRYSTAL_LINE and player:hasKeyItem(xi.ki.C_L_REPORTS)) then
            player:startEvent(711)
        elseif (currentMission == xi.mission.id.bastok.THE_EMISSARY and player:hasKeyItem(xi.ki.KINDRED_REPORT)) then
            player:startEvent(714)
        elseif (currentMission == xi.mission.id.bastok.THE_EMISSARY) then
            if (player:hasKeyItem(xi.ki.LETTER_TO_THE_CONSULS_BASTOK) == false and player:getMissionStatus(player:getNation()) ==
                0) then
                player:startEvent(713)
            else
                player:showText(npc, ID.text.GOOD_LUCK)
            end
        elseif (player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_BASTOK) and player:getMissionStatus(player:getNation()) == 0) then
            player:startEvent(720)
        elseif (currentMission == xi.mission.id.bastok.DARKNESS_RISING and player:getMissionStatus(player:getNation()) == 1) then
            player:startEvent(721)
        elseif (player:hasKeyItem(xi.ki.BURNT_SEAL)) then
            player:startEvent(722)
        elseif (currentMission == xi.mission.id.bastok.THE_PIRATE_S_COVE and player:getMissionStatus(player:getNation()) == 0) then
            player:startEvent(761)
        elseif (currentMission == xi.mission.id.bastok.THE_PIRATE_S_COVE and player:getMissionStatus(player:getNation()) == 3) then
            player:startEvent(762)
        else
            player:startEvent(700)
        end
    elseif (player:hasKeyItem(xi.ki.YASINS_SWORD)) then -- The Doorman
        player:startEvent(750)
    else
        player:startEvent(700)
    end

end

-- 710  711  700  713  714  715  717  720  721  750  1008  1009  761
-- 762  782  805  845  877  938  939  940  941  942  971  969  970
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 750) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:addItem(16678)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16678) -- Razor Axe
            player:delKeyItem(xi.ki.YASINS_SWORD)
            player:setCharVar("theDoormanCS", 0)
            player:addFame(BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16678) -- Razor Axe
        end
    elseif (csid == 710) then
        player:delKeyItem(xi.ki.ZERUHN_REPORT)
        player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
    elseif (csid == 713) then
        player:addKeyItem(xi.ki.LETTER_TO_THE_CONSULS_BASTOK)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_TO_THE_CONSULS_BASTOK)
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 720 and option == 0 or csid == 721) then
        player:delKeyItem(xi.ki.MESSAGE_TO_JEUNO_BASTOK)
        player:addKeyItem(xi.ki.NEW_FEIYIN_SEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.NEW_FEIYIN_SEAL)
        player:setMissionStatus(player:getNation(), 10)
    elseif (csid == 720 and option == 1) then
        player:delKeyItem(xi.ki.MESSAGE_TO_JEUNO_BASTOK)
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 761) then
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 714 or csid == 722 or csid == 762) then
        finishMissionTimeline(player, 1, csid, option);

        -- TRUST
    elseif csid == 980 then
        player:addSpell(897, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 897)
        player:setCharVar("BastokFirstTrust", 1)
    elseif csid == 982 then
        player:delKeyItem(xi.ki.BLUE_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.BLUE_INSTITUTE_CARD)
        npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.TRUST_BASTOK, {
            ki = xi.ki.BASTOK_TRUST_PERMIT,
            title = xi.title.THE_TRUSTWORTHY,
            var = "BastokFirstTrust"
        })
        player:messageSpecial(ID.text.CALL_MULTIPLE_ALTER_EGO)
    elseif csid == 984 then
        player:addSpell(897, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 897)
        player:delKeyItem(xi.ki.BLUE_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.BLUE_INSTITUTE_CARD)
        npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.TRUST_BASTOK, {
            ki = xi.ki.BASTOK_TRUST_PERMIT
        })
    end
end

return entity
