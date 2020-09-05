-----------------------------------
-- Area: Western Adoulin
--  NPC: Merleg
-- Type: Standard NPC and Quest Giver
-- Starts, Involved with, and Finishes Quest: 'A Pioneers Best (Imaginary) Friend'
-- !pos 34 0 -131 256
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/status")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local APBIF = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.A_PIONEERS_BEST_IMAGINARY_FRIEND)
    if (APBIF == QUEST_ACCEPTED) then
        if (player:hasStatusEffect(tpz.effect.IONIS)) then
            -- Finishing Quest: 'A Pioneers Best (Imaginary) Friend'
            player:startEvent(2522)
        else
            -- Dialgoue during Quest: 'A Pioneers Best (Imaginary) Friend'
            player:startEvent(2521)
        end
    elseif (APBIF == QUEST_AVAILABLE) then
        player:startEvent(2520)
    else
        -- Standard dialogue
        player:startEvent(543)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 2520) then
        -- Starting Quest: 'A Pioneers Best (Imaginary) Friend'
        player:addQuest(ADOULIN, tpz.quest.id.adoulin.A_PIONEERS_BEST_IMAGINARY_FRIEND)
        if (player:hasStatusEffect(tpz.effect.IONIS)) then
            -- Finishes quest if Ionis is already active
            player:startEvent(2522)
        end
    elseif (csid == 2522) then
        -- Finishing Quest: 'A Pioneers Best (Imaginary) Friend'
        player:completeQuest(ADOULIN, tpz.quest.id.adoulin.A_PIONEERS_BEST_IMAGINARY_FRIEND)
        player:addExp(500 * EXP_RATE)
        player:addCurrency('bayld', 200 * BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 200 * BAYLD_RATE)
        player:addKeyItem(tpz.ki.FAIL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FAIL_BADGE)
        player:addFame(ADOULIN)
    end
end
