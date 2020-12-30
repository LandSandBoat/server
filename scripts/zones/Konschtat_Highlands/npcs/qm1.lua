-----------------------------------
-- Area: Konschtat Highlands
--  NPC: qm1 (???)
-- Continues Quests: Past Perfect
-- !pos -201 16 80 108
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.PAST_PERFECT) == QUEST_ACCEPTED then
        player:addKeyItem(tpz.ki.TATTERED_MISSION_ORDERS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TATTERED_MISSION_ORDERS)
    else
        player:messageSpecial(ID.text.FIND_NOTHING)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
