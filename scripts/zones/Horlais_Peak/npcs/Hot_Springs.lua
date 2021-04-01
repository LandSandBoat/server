-----------------------------------
-- Area: Horlais Peak
--  NPC: Hot Springs
-- !pos 444 -37 -18 139
-----------------------------------
local ID = require("scripts/zones/Horlais_Peak/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL) == QUEST_ACCEPTED and trade:hasItemQty(1210, 1) and trade:getItemCount() == 1) then
        player:startEvent(2, 1210)
    end
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_GENERAL_S_SECRET) == QUEST_ACCEPTED) and (player:hasKeyItem(xi.ki.CURILLAS_BOTTLE_EMPTY) == true) then
        player:addKeyItem(xi.ki.CURILLAS_BOTTLE_FULL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CURILLAS_BOTTLE_FULL)
        player:delKeyItem(xi.ki.CURILLAS_BOTTLE_EMPTY)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 2) then
        player:tradeComplete()
        player:addItem(4949) -- Scroll of Jubaku: Ichi
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4949)
        player:addFame(NORG, 75)
        player:addTitle(xi.title.CRACKER_OF_THE_SECRET_CODE)
        player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL)
    end
end

return entity
