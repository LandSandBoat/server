-----------------------------------
-- Area: The Eldieme Necropolis (S)
--  NPC: Erlene
-- !pos 376.936 -39.999 17.914 175
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local aLittleKnowledge = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()
    local onSabbatical = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL)
    local onSabbaticalProgress = player:getCharVar("OnSabbatical")
    local downwardHelix = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX)

    -- TODO: Implement these two spells as a hidden quest
    if
        aLittleKnowledge == QUEST_COMPLETED and
        mJob == xi.job.SCH and
        mLvl >= 5 and
        not (player:hasSpell(xi.magic.spell.EMBRAVA) and player:hasSpell(xi.magic.spell.KAUSTRA))
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
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 47 then
        if
            player:canLearnSpell(xi.magic.spell.EMBRAVA) and
            player:canLearnSpell(xi.magic.spell.KAUSTRA)
        then
            player:addSpell(xi.magic.spell.EMBRAVA, true)
            player:addSpell(xi.magic.spell.KAUSTRA, true)
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
            player:addItem(xi.items.KLIMAFORM_SCHEMA) --klimaform
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.KLIMAFORM_SCHEMA)
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
            player:addItem(xi.items.SCHOLARS_BRACERS) -- Schlar's Bracers
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.SCHOLARS_BRACERS)
            player:setCharVar("DownwardHelix", 0)
        end
    end
end

return entity
