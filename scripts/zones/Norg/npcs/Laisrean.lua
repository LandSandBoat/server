-----------------------------------
-- Area: Norg
--  NPC: Laisrean
-- Starts and Ends Quest: The Sahagin's Stash
-- !pos -2.251 -1 21.654 252
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    Stash = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_SAHAGINS_STASH)
    mLvl = player:getMainLvl()
    SeaStatue = player:hasKeyItem(tpz.ki.SEA_SERPENT_STATUE)

    if (Stash == QUEST_AVAILABLE and player:getFameLevel(NORG) >= 4 and mLvl >= 5) then
        player:startEvent(33) -- Start quest
    elseif (Stash == QUEST_ACCEPTED) then
        if (SeaStatue == true) then
            player:startEvent(35, tpz.ki.SEA_SERPENT_STATUE) -- Finish quest
        else
            player:startEvent(34) -- Reminder Dialogue
        end
    else
        player:startEvent(83) -- Standard Conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 33 and option == 1) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.THE_SAHAGINS_STASH)
    elseif (csid == 35) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4946)
        else
            player:delKeyItem(tpz.ki.SEA_SERPENT_STATUE)
            player:addItem(4946) -- Scroll of Utsusemi: Ichi
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4946)
            player:addTitle(tpz.title.TREASUREHOUSE_RANSACKER)
            player:addFame(NORG, 75)
            player:completeQuest(OUTLANDS, tpz.quest.id.outlands.THE_SAHAGINS_STASH)
        end
    end

end
