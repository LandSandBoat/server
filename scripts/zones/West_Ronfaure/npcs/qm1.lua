-----------------------------------
-- Area: West Ronfaure
--  NPC: qm1 (???)
-- Involved in Quest: The Dismayed Customer
-- !pos -453 -20 -230 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_DISMAYED_CUSTOMER) == QUEST_ACCEPTED and player:getCharVar("theDismayedCustomer") == 1 then
        player:addKeyItem(tpz.ki.GULEMONTS_DOCUMENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.GULEMONTS_DOCUMENT)
        player:setCharVar("theDismayedCustomer", 0)
    else
        player:messageSpecial(ID.text.DISMAYED_CUSTOMER)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
