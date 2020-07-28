-----------------------------------
-- Area: Port Windurst
--  NPC: Ohruru
-- Starts & Finishes Repeatable Quest: Catch me if you can
-- Involved in Quest: Wonder Wands
-- Note: Animation for his "Cure" is not functioning. Unable to capture option 1, so if the user says no, he heals them anyways.
-- !pos -108 -5 94 240
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
--    player:delQuest(WINDURST, tpz.quest.id.windurst.CATCH_IT_IF_YOU_CAN) -- ======== FOR TESTING ONLY ==========-----
-- ======== FOR TESTING ONLY ==========-----
--    if (player:getCharVar("QuestCatchItIfYouCan_var") == 0 and player:hasStatusEffect(tpz.effect.MUTE) == false and player:hasStatusEffect(tpz.effect.BANE) == false and player:hasStatusEffect(tpz.effect.PLAGUE) == false) then
--        rand = math.random(1, 3)
--        if (rand == 1) then
--            player:addStatusEffect(tpz.effect.MUTE, 0, 0, 100)
--        elseif (rand == 2) then
--            player:addStatusEffect(tpz.effect.BANE, 0, 0, 100)
--        elseif (rand == 3) then
--            player:addStatusEffect(tpz.effect.PLAGUE, 0, 0, 100)
--        end
--    end
-- ======== FOR TESTING ONLY ==========-----

    Catch = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CATCH_IT_IF_YOU_CAN)
    WonderWands = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WONDER_WANDS)
    if (WonderWands == QUEST_ACCEPTED) then
        player:startEvent(258, 0, 17053)
    elseif (Catch == 0) then
        prog = player:getCharVar("QuestCatchItIfYouCan_var")
        if (prog == 0) then
            player:startEvent(230) -- CATCH IT IF YOU CAN: Before Quest 1
            player:setCharVar("QuestCatchItIfYouCan_var", 1)
        elseif (prog == 1) then
            player:startEvent(253) -- CATCH IT IF YOU CAN: Before Start
            player:setCharVar("QuestCatchItIfYouCan_var", 2)
        elseif (prog == 2) then
            player:startEvent(231) -- CATCH IT IF YOU CAN: Before Quest 2
        end

    elseif (Catch >= 1 and (player:hasStatusEffect(tpz.effect.MUTE) == true or player:hasStatusEffect(tpz.effect.BANE) == true or player:hasStatusEffect(tpz.effect.PLAGUE) == true)) then
        player:startEvent(246) -- CATCH IT IF YOU CAN: Quest Turn In 1
    elseif (Catch >= 1 and player:needToZone()) then
        player:startEvent(255) -- CATCH IT IF YOU CAN: After Quest
    elseif (Catch == 1 and player:hasStatusEffect(tpz.effect.MUTE) == false and player:hasStatusEffect(tpz.effect.BANE) == false and player:hasStatusEffect(tpz.effect.PLAGUE) == false) then
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(248) -- CATCH IT IF YOU CAN: During Quest 1
        else
            player:startEvent(251) -- CATCH IT IF YOU CAN: During Quest 2
        end
    elseif (WonderWands == QUEST_COMPLETED) then
        player:startEvent(265)
    else
        player:startEvent(230) -- STANDARD CONVERSATION
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 231) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.CATCH_IT_IF_YOU_CAN)
    elseif (csid == 246 and option == 0) then
        player:needToZone(true)
        if (player:hasStatusEffect(tpz.effect.MUTE) == true) then
            player:delStatusEffect(tpz.effect.MUTE)
            player:addGil(GIL_RATE*1000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*1000)
        elseif (player:hasStatusEffect(tpz.effect.BANE) == true) then
            player:delStatusEffect(tpz.effect.BANE)
            player:addGil(GIL_RATE*1200)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*1200)
        elseif (player:hasStatusEffect(tpz.effect.PLAGUE) == true) then
            player:delStatusEffect(tpz.effect.PLAGUE)
            player:addGil(GIL_RATE*1500)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*1500)
        end

        player:setCharVar("QuestCatchItIfYouCan_var", 0)

        if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CATCH_IT_IF_YOU_CAN) == QUEST_ACCEPTED) then
            player:completeQuest(WINDURST, tpz.quest.id.windurst.CATCH_IT_IF_YOU_CAN)
            player:addFame(WINDURST, 75)
        else
            player:addFame(WINDURST, 8)
        end
    end
end
