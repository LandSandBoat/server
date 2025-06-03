-----------------------------------
-- Area: Uleguerand Range
--  NPC: Chamnaet Spring
--  Receive Chamnaet Ice upon trading Cotton Pouch
-- !pos -305.240 3.605 17.977
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade Cotton Pouch
    if trade:hasItemQty(xi.item.COTTON_POUCH, 1) and trade:getItemCount() == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.HANDFUL_OF_CHAMNAET_ICE) -- Chamnaet Ice
        else
            player:tradeComplete()
            player:addItem(xi.item.HANDFUL_OF_CHAMNAET_ICE)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.HANDFUL_OF_CHAMNAET_ICE) -- Chamnaet Ice
        end
    end
end

return entity
