-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Mashira
-- Involved in Quests: Rubbish day, Making Amens!
-- !pos 141 -6 138 200
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RUBBISH_DAY) == QUEST_ACCEPTED and player:getCharVar("RubbishDayVar") == 0) then
        player:startEvent(11, 1) -- For the quest "Rubbish day"
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_AMENS) == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.BROKEN_WAND) == true) then
            player:startEvent(11, 3)
        else player:startEvent(11, 0) -- Making Amens dialogue
        end
    else
        player:startEvent(11, 3) -- Standard dialog and menu
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
RubbishDay = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RUBBISH_DAY)
MakingAmens = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_AMENS)
    if (csid == 11 and option == 1 and RubbishDay == QUEST_ACCEPTED) then
        player:delKeyItem(tpz.ki.MAGIC_TRASH)
        player:setCharVar("RubbishDayVar", 1)
    elseif (csid == 11 and option == 0 and MakingAmens == QUEST_ACCEPTED) then
        player:addKeyItem(tpz.ki.BROKEN_WAND) --Broken Wand
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BROKEN_WAND)
        player:tradeComplete()
    end
end
