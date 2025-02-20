-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Corua
-- Ronfaure Regional Merchant
-- !pos -66 2 -11 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.RONFAURE) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.CORUA_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.SAN_DORIAN_CARROT,           33,
            xi.item.BUNCH_OF_SAN_DORIAN_GRAPES,  79,
            xi.item.RONFAURE_CHESTNUT,          124,
            xi.item.BAG_OF_SAN_DORIAN_FLOUR,     62,
        }

        player:showText(npc, ID.text.CORUA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
