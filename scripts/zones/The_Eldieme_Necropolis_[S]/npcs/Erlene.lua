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
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local ALittleKnowledge = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    local ALittleKnowledgeProgress = player:getCharVar("ALittleKnowledge")

    if (ALittleKnowledge == QUEST_ACCEPTED and ALittleKnowledgeProgress == 1) then
        if (trade:hasItemQty(2550, 12) and trade:getGil() == 0 and trade:getItemCount() == 12) then
            if( player:getMainJob() == tpz.job.BLM or
                player:getMainJob() == tpz.job.RDM or
                player:getMainJob() == tpz.job.SMN or
                player:getMainJob() == tpz.job.BLU) then
                player:startEvent(12, 1)
            else
                player:startEvent(12)
            end
        end
    end
end

function onTrigger(player, npc)

    local ALittleKnowledge = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    local ALittleKnowledgeProgress = player:getCharVar("ALittleKnowledge")
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()
    local onSabbatical = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.ON_SABBATICAL)
    local onSabbaticalProgress = player:getCharVar("OnSabbatical")
    local downwardHelix = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.DOWNWARD_HELIX)

    if (ALittleKnowledge == QUEST_AVAILABLE) then
        if (mLvl >= ADVANCED_JOB_LEVEL) then
            player:startEvent(10, 1)
        else
            player:startEvent(10)
        end
    elseif (ALittleKnowledgeProgress == 1 and ALittleKnowledge == QUEST_ACCEPTED) then
        player:startEvent(11)
    elseif (ALittleKnowledgeProgress == 2 and ALittleKnowledge == QUEST_ACCEPTED) then
        if (player:hasStatusEffect(tpz.effect.MANAFONT) or
            player:hasStatusEffect(tpz.effect.CHAINSPELL) or
            player:hasStatusEffect(tpz.effect.ASTRAL_FLOW) or
            player:hasStatusEffect(tpz.effect.AZURE_LORE)) then
            player:startEvent(14)
        else
            player:startEvent(13)
        end
    elseif (ALittleKnowledge == QUEST_COMPLETED and mJob == tpz.job.SCH and mLvl >= 5 and not (player:hasSpell(478) and player:hasSpell(502))) then
            player:startEvent(47)
    elseif (onSabbatical == QUEST_AVAILABLE and mJob == tpz.job.SCH and mLvl >= AF1_QUEST_LEVEL) then
            player:startEvent(18)
    elseif (onSabbatical == QUEST_ACCEPTED) then
        if (onSabbaticalProgress < 3) then
            player:startEvent(19)
        else
            player:startEvent(20)
        end
    elseif (onSabbatical == QUEST_COMPLETED and player:getCharVar("Erlene_Sabbatical_Timer")~=VanadielDayOfTheYear() and mJob == tpz.job.SCH and mLvl >= AF2_QUEST_LEVEL and downwardHelix == QUEST_AVAILABLE) then
        player:startEvent(23)
    elseif (downwardHelix == QUEST_ACCEPTED) then
        if (player:getCharVar("DownwardHelix") == 0) then
            player:startEvent(24)
        elseif (player:getCharVar("DownwardHelix") == 1) then
            player:startEvent(25)
        elseif (player:getCharVar("DownwardHelix") < 4) then
            player:startEvent(26)
        else
            player:startEvent(27)
        end
    else
        player:startEvent(15)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 10 and option == 0) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
        player:setCharVar("ALittleKnowledge", 1)
    elseif (csid == 12) then
        player:tradeComplete()
        player:setCharVar("ALittleKnowledge", 2)
    elseif (csid == 14) then
        player:addKeyItem(tpz.ki.GRIMOIRE)
        player:unlockJob(tpz.job.SCH)
        player:addTitle(tpz.title.SCHULTZ_SCHOLAR)
        player:setCharVar("ALittleKnowledge", 0)
        player:setCharVar("SheetsofVellum", 0)
        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_SCHOLAR)
        player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    elseif (csid == 47) then
        if (player:canLearnSpell(478) and player:canLearnSpell(502)) then
            player:addSpell(478, true)
            player:addSpell(502, true)
            player:messageSpecial(ID.text.YOU_LEARN_EMBRAVA_AND_KAUSTRA)
        end
    elseif (csid == 18) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.ON_SABBATICAL)
        player:addKeyItem(tpz.ki.ULBRECHTS_SEALED_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ULBRECHTS_SEALED_LETTER)
        player:setCharVar("OnSabbatical", 1)
    elseif (csid == 20) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
        else
            player:delKeyItem(tpz.ki.ULBRECHTS_SEALED_LETTER)
            player:delKeyItem(tpz.ki.SCHULTS_SEALED_LETTER)
            player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.ON_SABBATICAL)
            player:addItem(6058) --klimaform
            player:messageSpecial(ID.text.ITEM_OBTAINED, 6058)
            player:setCharVar("onSabbatical", 0)
            player:setCharVar("Erlene_Sabbatical_Timer", VanadielDayOfTheYear())
        end
    elseif (csid == 23) then
        player:setCharVar("Erlene_Sabbatical_Timer", 0)
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.DOWNWARD_HELIX)
    elseif (csid == 25) then
        player:setCharVar("DownwardHelix", 2)
    elseif (csid == 27) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
        else
            player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.DOWNWARD_HELIX)
            player:addItem(15004) -- Schlar's Bracers
            player:messageSpecial(ID.text.ITEM_OBTAINED, 15004)
            player:setCharVar("DownwardHelix", 0)
        end
    end
end
