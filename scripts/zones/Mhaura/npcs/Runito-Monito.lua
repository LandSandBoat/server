-----------------------------------
-- Area: Mhaura
--  NPC: Runito-Monito
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CAT_BAGHNAKHS,    120 },
        { xi.item.BRASS_BAGHNAKHS, 1757 },
        { xi.item.BRASS_DAGGER,     967 },
        { xi.item.BRONZE_ROD,       104 },
        { xi.item.BRASS_ROD,        717 },
        { xi.item.BRASS_XIPHOS,    4071 },
        { xi.item.CLAYMORE,        2828 },
        { xi.item.BUTTERFLY_AXE,    698 },
        { xi.item.DART,              10 },
        { xi.item.WOODEN_ARROW,       4 },
        { xi.item.BONE_ARROW,         5 },
        { xi.item.CROSSBOW_BOLT,      6 },
    }

    player:showText(npc, zones[xi.zone.MHAURA].text.RUNITOMONITO_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
