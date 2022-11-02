-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Cradle_of_Rebirth
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade Flaxen Pouch
    if trade:hasItemQty(1777, 1) and trade:getItemCount() == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1778) -- Parradamo Stones
        else
            player:tradeComplete()
            player:addItem(1778)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1778) -- Parradamo Stones
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
