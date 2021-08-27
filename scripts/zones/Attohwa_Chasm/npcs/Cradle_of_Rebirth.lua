-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Cradle_of_Rebirth
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/settings/main")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade Flaxen Pouch
    if (trade:hasItemQty(1777, 1) and trade:getItemCount() == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1778) -- Parradamo Stones
        else
            player:tradeComplete()
            player:addItem(1778)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1778) -- Parradamo Stones
        end
    end
end

entity.onTrigger = function(player, npc)
    if (player:hasKeyItem(xi.ki.MIMEO_JEWEL) == true) then
        player:delKeyItem(xi.ki.MIMEO_JEWEL)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.MIMEO_JEWEL)
        player:addKeyItem(xi.ki.MIMEO_FEATHER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MIMEO_FEATHER)
        player:addKeyItem(xi.ki.SECOND_MIMEO_FEATHER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SECOND_MIMEO_FEATHER)
        player:addKeyItem(xi.ki.THIRD_MIMEO_FEATHER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.THIRD_MIMEO_FEATHER)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
