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
require("scripts/globals/zone")
-----------------------------------
local entity = {}

local TrustMemory = function(player)
    local memories = 0
    if player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS) then
        memories = memories + 2
    end
    -- 4 - nothing
    if player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING) then
        memories = memories + 8
    end
    -- 16 - chocobo racing
    --  memories = memories + 16
    return memories
end

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(4365, 1) and -- Rolanberry
        trade:getItemCount() == 1 and
        player:getNation() == xi.nation.WINDURST and
        player:getRank(player:getNation()) >= 2 and
        not player:hasKeyItem(xi.ki.PORTAL_CHARM)
    then
        if player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.WRITTEN_IN_THE_STARS) then
            player:startEvent(291) -- Qualifies for the reward immediately
        else
            player:startEvent(292) -- Kupipi owes you the portal charm later
        end
    end
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()
    local currentMission = player:getCurrentMission(pNation)
    local missionStatus = player:getMissionStatus(player:getNation())

    local TrustSandoria = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
    local TrustBastok   = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)
    local TrustWindurst = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)
    local WindurstFirstTrust = player:getCharVar("WindurstFirstTrust")
    local KupipiTrustChatFlag = player:getLocalVar("KupipiTrustChatFlag")
    local Rank3 = player:getRank(player:getNation()) >= 3 and 1 or 0

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
    elseif pNation == xi.nation.WINDURST then
        if currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS and missionStatus == 0 then
            player:startEvent(95, 0, 0, 0, xi.ki.LETTER_TO_THE_CONSULS_WINDURST)
        elseif currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS and missionStatus == 11 then
            player:startEvent(101, 0, 0, xi.ki.ADVENTURERS_CERTIFICATE)
        elseif currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS then
            player:startEvent(97)
        elseif currentMission == xi.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT and missionStatus == 0 then
            player:startEvent(103, 0, 0, xi.ki.STARWAY_STAIRWAY_BAUBLE)
        elseif currentMission == xi.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT and missionStatus == 1 then
            player:startEvent(104)
        elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and missionStatus == 3 then
            player:startEvent(326)
        elseif player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.WRITTEN_IN_THE_STARS) and player:getCharVar("OwesPortalCharm") == 1 then
            player:startEvent(293) -- Kupipi repays your favor
        elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.MOON_READING and missionStatus >= 3 then
            player:startEvent(400) -- Kupipi in disbelief over player becoming Rank 10
        elseif pNation == xi.nation.WINDURST and player:getRank(player:getNation()) == 10 then
            player:startEvent(408) -- After achieving Windurst Rank 10, Kupipi has more to say
        else
            player:startEvent(251)
        end
    else
        player:startEvent(251)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 95 then
        player:setMissionStatus(player:getNation(), 1)
        player:addKeyItem(xi.ki.LETTER_TO_THE_CONSULS_WINDURST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_TO_THE_CONSULS_WINDURST)
    elseif csid == 103 then
        player:setMissionStatus(player:getNation(), 1)
        player:addKeyItem(xi.ki.STARWAY_STAIRWAY_BAUBLE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.STARWAY_STAIRWAY_BAUBLE)
    elseif csid == 101 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 291 then -- All condition met, grant Portal Charm
        player:tradeComplete()
        player:addKeyItem(xi.ki.PORTAL_CHARM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.PORTAL_CHARM)
    elseif csid == 292 then -- Traded rolanberry, but not all conditions met
        player:tradeComplete()
        player:setCharVar("OwesPortalCharm", 1)
    elseif csid == 293 then -- Traded rolanberry before, and all conditions are now met
        player:setCharVar("OwesPortalCharm", 0)
        player:addKeyItem(xi.ki.PORTAL_CHARM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.PORTAL_CHARM)
    elseif csid == 326 then
        player:setMissionStatus(player:getNation(), 4)
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
        player:delKeyItem(xi.ki.GREEN_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.GREEN_INSTITUTE_CARD)
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.TRUST_WINDURST, {
            ki = xi.ki.WINDURST_TRUST_PERMIT,
            title = xi.title.THE_TRUSTWORTHY,
            var = "WindurstFirstTrust" })
        player:messageSpecial(ID.text.CALL_MULTIPLE_ALTER_EGO)
    elseif csid == 439 then
        player:addSpell(898, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 898)
        player:delKeyItem(xi.ki.GREEN_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.GREEN_INSTITUTE_CARD)
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.TRUST_WINDURST, {
            ki = xi.ki.WINDURST_TRUST_PERMIT })
    end
end

return entity
