-----------------------------------
-- Area: Horlais Peak
--  NPC: Hot Springs
-- !pos 444 -37 -18 139
-----------------------------------
local ID = require("scripts/zones/Horlais_Peak/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL) == QUEST_ACCEPTED and
        trade:hasItemQty(xi.items.DAMP_SCROLL, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(2, xi.items.DAMP_SCROLL)
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2 then
        player:tradeComplete()
        player:addItem(xi.items.SCROLL_OF_JUBAKU_ICHI)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.SCROLL_OF_JUBAKU_ICHI)
        player:addFame(xi.quest.fame_area.NORG, 75)
        player:addTitle(xi.title.CRACKER_OF_THE_SECRET_CODE)
        player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL)
    end
end

return entity
