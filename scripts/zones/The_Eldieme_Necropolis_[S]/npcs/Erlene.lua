-----------------------------------
-- Area: The Eldieme Necropolis (S)
--  NPC: Erlene
-- Involved in Quest: "A Little Knowledge"
-- !pos 376.936 -39.999 17.914 175
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local aLittleKnowledge = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    local aLittleKnowledgeProgress = player:getCharVar("ALittleKnowledge")

    if aLittleKnowledge == QUEST_ACCEPTED and aLittleKnowledgeProgress == 1 then
        if
            trade:hasItemQty(2550, 12) and
            trade:getGil() == 0 and
            trade:getItemCount() == 12
        then
            if
                player:getMainJob() == xi.job.BLM or
                player:getMainJob() == xi.job.RDM or
                player:getMainJob() == xi.job.SMN or
                player:getMainJob() == xi.job.BLU
            then
                player:startEvent(12, 1)
            else
                player:startEvent(12)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local aLittleKnowledge = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    local aLittleKnowledgeProgress = player:getCharVar("ALittleKnowledge")
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()
    local onSabbatical = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL)
    local onSabbaticalProgress = player:getCharVar("OnSabbatical")
    local downwardHelix = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX)

    if aLittleKnowledge == QUEST_AVAILABLE then
        if mLvl >= xi.settings.main.ADVANCED_JOB_LEVEL then
            player:startEvent(10, 1)
        else
            player:startEvent(10)
        end
    elseif aLittleKnowledgeProgress == 1 and aLittleKnowledge == QUEST_ACCEPTED then
        player:startEvent(11)
    elseif aLittleKnowledgeProgress == 2 and aLittleKnowledge == QUEST_ACCEPTED then
        if
            player:hasStatusEffect(xi.effect.MANAFONT) or
            player:hasStatusEffect(xi.effect.CHAINSPELL) or
            player:hasStatusEffect(xi.effect.ASTRAL_FLOW) or
            player:hasStatusEffect(xi.effect.AZURE_LORE)
        then
            player:startEvent(14)
        else
            player:startEvent(13)
        end
    elseif
        aLittleKnowledge == QUEST_COMPLETED and
        mJob == xi.job.SCH and
        mLvl >= 5 and
        not (player:hasSpell(478) and player:hasSpell(502))
    then
        player:startEvent(47)
    elseif
        onSabbatical == QUEST_AVAILABLE and
        mJob == xi.job.SCH and
        mLvl >= xi.settings.main.AF1_QUEST_LEVEL
    then
        player:startEvent(18)
    elseif onSabbatical == QUEST_ACCEPTED then
        if onSabbaticalProgress < 3 then
            player:startEvent(19)
        else
            player:startEvent(20)
        end
    elseif
        onSabbatical == QUEST_COMPLETED and
        player:getCharVar("Erlene_Sabbatical_Timer") ~= VanadielDayOfTheYear() and
        mJob == xi.job.SCH and
        mLvl >= xi.settings.main.AF2_QUEST_LEVEL and
        downwardHelix == QUEST_AVAILABLE
    then
        player:startEvent(23)
    elseif downwardHelix == QUEST_ACCEPTED then
        if player:getCharVar("DownwardHelix") == 0 then
            player:startEvent(24)
        elseif player:getCharVar("DownwardHelix") == 1 then
            player:startEvent(25)
        elseif player:getCharVar("DownwardHelix") < 4 then
            player:startEvent(26)
        else
            player:startEvent(27)
        end
    else
        player:startEvent(15)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10 and option == 0 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
        player:setCharVar("ALittleKnowledge", 1)
    elseif csid == 12 then
        player:tradeComplete()
        player:setCharVar("ALittleKnowledge", 2)
    elseif csid == 14 then
        player:addKeyItem(xi.ki.GRIMOIRE)
        player:unlockJob(xi.job.SCH)
        player:addTitle(xi.title.SCHULTZ_SCHOLAR)
        player:setCharVar("ALittleKnowledge", 0)
        player:setCharVar("SheetsofVellum", 0)
        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_SCHOLAR)
        player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    elseif csid == 47 then
        if player:canLearnSpell(478) and player:canLearnSpell(502) then
            player:addSpell(478, true)
            player:addSpell(502, true)
            player:messageSpecial(ID.text.YOU_LEARN_EMBRAVA_AND_KAUSTRA)
        end
    elseif csid == 18 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL)
        player:addKeyItem(xi.ki.ULBRECHTS_SEALED_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ULBRECHTS_SEALED_LETTER)
        player:setCharVar("OnSabbatical", 1)
    elseif csid == 20 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
        else
            player:delKeyItem(xi.ki.ULBRECHTS_SEALED_LETTER)
            player:delKeyItem(xi.ki.SCHULTZS_SEALED_LETTER)
            player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL)
            player:addItem(6058) --klimaform
            player:messageSpecial(ID.text.ITEM_OBTAINED, 6058)
            player:setCharVar("onSabbatical", 0)
            player:setCharVar("Erlene_Sabbatical_Timer", VanadielDayOfTheYear())
        end
    elseif csid == 23 then
        player:setCharVar("Erlene_Sabbatical_Timer", 0)
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX)
    elseif csid == 25 then
        player:setCharVar("DownwardHelix", 2)
    elseif csid == 27 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
        else
            player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX)
            player:addItem(15004) -- Schlar's Bracers
            player:messageSpecial(ID.text.ITEM_OBTAINED, 15004)
            player:setCharVar("DownwardHelix", 0)
        end
    end
end

return entity
