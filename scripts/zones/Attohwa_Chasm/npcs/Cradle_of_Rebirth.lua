-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Cradle_of_Rebirth
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade Flaxen Pouch
    if trade:hasItemQty(xi.item.FLAXEN_POUCH, 1) and trade:getItemCount() == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.POUCH_OF_PARRADAMO_STONES) -- Parradamo Stones
        else
            player:tradeComplete()
            player:addItem(xi.item.POUCH_OF_PARRADAMO_STONES)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.POUCH_OF_PARRADAMO_STONES) -- Parradamo Stones
        end
    end
end

return entity
