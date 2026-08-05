-----------------------------------
-- Area: Mhaura
--  NPC: Runito-Monito
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CAT_BAGHNAKHS,    116 },
        { xi.item.BRASS_BAGHNAKHS, 1690 },
        { xi.item.BRASS_DAGGER,     930 },
        { xi.item.BRONZE_ROD,       100 },
        { xi.item.BRASS_ROD,        690 },
        { xi.item.BRASS_XIPHOS,    3915 },
        { xi.item.CLAYMORE,        2720 },
        { xi.item.BUTTERFLY_AXE,    672 },
        { xi.item.DART,              10 },
        { xi.item.WOODEN_ARROW,       4 },
        { xi.item.BONE_ARROW,         5 },
        { xi.item.CROSSBOW_BOLT,      6 },
    }

    player:showText(npc, zones[xi.zone.MHAURA].text.RUNITOMONITO_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
