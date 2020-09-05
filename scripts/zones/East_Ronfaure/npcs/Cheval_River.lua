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

function onTrade(player, npc, trade)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.WATER_OF_THE_CHEVAL) == QUEST_ACCEPTED and trade:hasItemQty(602, 1)) then
        if (trade:getItemCount() == 1 and player:getFreeSlotsCount() > 0) then
            player:tradeComplete()
            player:addItem(603)
            player:messageSpecial(ID.text.CHEVAL_RIVER_WATER, 603)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 603)
        end
    end

end

function onTrigger(player, npc)

    if (player:hasItem(602) == true) then
        player:messageSpecial(ID.text.BLESSED_WATERSKIN)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

end
