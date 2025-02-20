-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Pourette
-- Derfland Regional Merchant
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.DERFLAND) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.POURETTE_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.BUNCH_OF_GYSAHL_GREENS,   70,
            xi.item.GINGER_ROOT,             161,
            xi.item.FLASK_OF_OLIVE_OIL,       16,
            xi.item.WIJNRUIT,                124,
            xi.item.DERFLAND_PEAR,           145,
            xi.item.OLIVE_FLOWER,           1872,
        }

        player:showText(npc, ID.text.POURETTE_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
