-----------------------------------
-- Area: East Ronfaure
--  NPC: Cheval_River
-- !pos 223 -58 426 101
--  Involved in Quest: Waters of Cheval
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/East_Ronfaure/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WATER_OF_THE_CHEVAL) == QUEST_ACCEPTED and trade:hasItemQty(602, 1)) then
        if (trade:getItemCount() == 1 and player:getFreeSlotsCount() > 0) then
            player:tradeComplete()
            player:addItem(603)
            player:messageSpecial(ID.text.CHEVAL_RIVER_WATER, 603)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 603)
        end
    end

end

entity.onTrigger = function(player, npc)

    if (player:hasItem(602) == true) then
        player:messageSpecial(ID.text.BLESSED_WATERSKIN)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

end

return entity
