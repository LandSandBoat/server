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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.PAST_PERFECT) == QUEST_ACCEPTED then
        player:addKeyItem(tpz.ki.TATTERED_MISSION_ORDERS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TATTERED_MISSION_ORDERS)
    else
        player:messageSpecial(ID.text.FIND_NOTHING)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
