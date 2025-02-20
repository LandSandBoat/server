-----------------------------------
-- Area: Bastok_Mines
--  NPC: Faustin
-- Ronfaure Regional Merchant
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.RONFAURE) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.FAUSTIN_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.SAN_DORIAN_CARROT,           33,
            xi.item.BUNCH_OF_SAN_DORIAN_GRAPES,  79,
            xi.item.RONFAURE_CHESTNUT,          124,
            xi.item.BAG_OF_SAN_DORIAN_FLOUR,     62,
        }

        player:showText(npc, ID.text.FAUSTIN_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
