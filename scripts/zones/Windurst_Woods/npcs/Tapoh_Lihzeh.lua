-----------------------------------
-- Area: Windurst Woods
--  NPC: Tapoh Lihzeh
-- Starts & Finishes Repeatable Quest: Paying Lip Service
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    -- CHOCOBILIOUS
    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CHOCOBILIOUS) == QUEST_ACCEPTED and player:getCharVar("ChocobiliousQuest") == 1 and npcUtil.tradeHas(trade, 938) then
        player:startEvent(229, 0, 938)

    -- PAYING LIP SERVICE
    elseif player:getQuestStatus(WINDURST, tpz.quest.id.windurst.PAYING_LIP_SERVICE) >= QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, {{912, 3}}) then
            player:startEvent(479, 0, 912, 1016, 0, 1)
        elseif npcUtil.tradeHas(trade, {{1016, 2}}) then
            player:startEvent(479, 0, 912, 1016, 0, 0)
        end
    end
end

function onTrigger(player, npc)
    local chocobilious = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CHOCOBILIOUS)
    local chocobiliousCS = player:getCharVar("ChocobiliousQuest")
    local payingLipService = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.PAYING_LIP_SERVICE)

    -- CHOCOBILIOUS
    if chocobilious == QUEST_ACCEPTED and chocobiliousCS == 2 then
        player:startEvent(230) -- after trading
    elseif chocobilious == QUEST_ACCEPTED and chocobiliousCS == 1 then
        player:startEvent(228, 0, 938) -- after first talk
    elseif chocobilious == QUEST_ACCEPTED then
        player:startEvent(227, 0, 938) -- first talk

    -- PAYING LIP SERVICE
    elseif payingLipService == QUEST_ACCEPTED then
        player:startEvent(478, 0, 912, 1016, GIL_RATE*150, GIL_RATE*200)
    elseif payingLipService == QUEST_AVAILABLE then
        player:startEvent(477, 0, 912, 1016, GIL_RATE*150, GIL_RATE*200)

    -- STANDARD DIALOG
    else
        player:startEvent(437)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- CHOCOBILIOUS
    if csid == 227 then
        player:setCharVar("ChocobiliousQuest", 1)
    elseif csid == 229 then
        player:setCharVar("ChocobiliousQuest", 2)

    -- PAYING LIP SERVICE
    elseif csid == 477 and option == 1 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.PAYING_LIP_SERVICE)
    elseif csid == 479 then
        if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.PAYING_LIP_SERVICE) == QUEST_ACCEPTED then
            npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.PAYING_LIP_SERVICE, {fame=60, title=tpz.title.KISSER_MAKEUPPER})
        else
            player:addFame(WINDURST, 8)
        end

        if option == 1 then
            player:addGil(GIL_RATE*150)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*150)
        else
            player:addGil(GIL_RATE*200)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*200)
        end

        player:confirmTrade()
    end
end
