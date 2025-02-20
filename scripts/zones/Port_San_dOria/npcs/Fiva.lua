-----------------------------------
-- Area: Port San d'Oria
--  NPC: Fiva
-- Kolshushu Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.KOLSHUSHU) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.FIVA_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.BULB_OF_MHAURA_GARLIC,      83,
            xi.item.YAGUDO_CHERRY,              45,
            xi.item.SLICE_OF_DHALMEL_MEAT,     249,
            xi.item.BUNCH_OF_BUBURIMU_GRAPES,  208,
            xi.item.CASABLANCA,               1872,
        }

        player:showText(npc, ID.text.FIVA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
