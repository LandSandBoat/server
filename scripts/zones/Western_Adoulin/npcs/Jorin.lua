-----------------------------------
-- Area: Western Adoulin
--  NPC: Jorin
-- Type: Standard NPC and Quest Giver
-- Starts, Involved with, and Finishes Quest: 'The Old Man and the Harpoon'
-- !pos 92 32 152 256
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TOMATH = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON)
    if (TOMATH == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.EXTRAVAGANT_HARPOON)) then
            -- Finishing Quest: 'The Old Man and the Harpoon'
            player:startEvent(2542)
        else
            -- Dialgoue during Quest: 'The Old Man and the Harpoon'
            player:startEvent(2541)
        end
    elseif (TOMATH == QUEST_AVAILABLE) then
        -- Starts Quest: 'The Old Man and the Harpoon'
        player:startEvent(2540)
    else
        -- Standard dialogue
        player:startEvent(560)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 2540) then
        -- Starting Quest: 'The Old Man and the Harpoon'
        player:addQuest(ADOULIN, tpz.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON)
        player:addKeyItem(tpz.ki.BROKEN_HARPOON)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BROKEN_HARPOON)
    elseif (csid == 2542) then
        -- Finishing Quest: 'The Old Man and the Harpoon'
        player:completeQuest(ADOULIN, tpz.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON)
        player:addExp(500 * EXP_RATE)
        player:addCurrency('bayld', 300 * BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 300 * BAYLD_RATE)
        player:delKeyItem(tpz.ki.EXTRAVAGANT_HARPOON)
        player:addFame(ADOULIN)
    end
end
