-----------------------------------
-- Area: Lower Jeuno
--  NPC: Sattal-Mansal
-- Starts and Finishes Quest: Mysteries of Beadeaux I & II
-- !pos 40 3 -53 245
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_I) == QUEST_ACCEPTED and trade:hasItemQty(495, 1) and trade:getItemCount() == 1) then
        player:startEvent(91) -- Ending quest Mysteries I
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_II) == QUEST_ACCEPTED and trade:hasItemQty(494, 1) and trade:getItemCount() == 1) then
        player:startEvent(92) -- Ending quest Mysteries II
    end
end

function onTrigger(player, npc)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_I) == QUEST_AVAILABLE and player:hasKeyItem(tpz.ki.SILVER_BELL)) then --Magicite Mission active (receive this KI after the first CS with aldo)
        player:startEvent(89) -- Start quests
    else
        player:startEvent(96) -- Standard dialog
    end
end
--
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 89) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_I)
        player:addQuest(JEUNO, tpz.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_II)
    elseif (csid == 91) then
        player:addKeyItem(tpz.ki.CORUSCANT_ROSARY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CORUSCANT_ROSARY)
        player:addFame(JEUNO, 30)
        player:tradeComplete(trade)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_I)
    elseif (csid == 92) then
        player:addKeyItem(tpz.ki.BLACK_MATINEE_NECKLACE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BLACK_MATINEE_NECKLACE)
        player:addFame(JEUNO, 30)
        player:tradeComplete(trade)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_II)
    end
end
