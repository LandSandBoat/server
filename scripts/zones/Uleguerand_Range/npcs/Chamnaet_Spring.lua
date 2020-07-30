-----------------------------------
-- Area: Uleguerand Range
--  NPC: Chamnaet Spring
--  Receive Chamnaet Ice upon trading Cotton Pouch
-- !pos -305.240 3.605 17.977
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
    -- Trade Cotton Pouch
    if (trade:hasItemQty(1779, 1) and trade:getItemCount() == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1780) -- Chamnaet Ice
        else
            player:tradeComplete()
            player:addItem(1780)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1780) -- Chamnaet Ice
        end
    end
end

function onTrigger(player, npc)
end
