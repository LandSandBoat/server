-----------------------------------
-- Area: Windurst Waters
--  NPC: Orez-Ebrez
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HEADGEAR,          2013, 3 },
        { xi.item.CIRCLET,            166, 2 },
        { xi.item.POETS_CIRCLET,     2152, 2 },
        { xi.item.HACHIMAKI,          858, 3 },
        { xi.item.COTTON_HEADBAND,   2080, 3 },
        { xi.item.BRONZE_CAP,         174, 3 },
        { xi.item.COTTON_HEADGEAR,   9274, 2 },
        { xi.item.LEATHER_BANDANA,    457, 2 },
        { xi.item.WINDSHEAR_HAT,      780, 3 },
        { xi.item.FLAX_HEADBAND,    16640, 2 },
        { xi.item.COTTON_HACHIMAKI,  5079, 2 },
        { xi.item.BRASS_CAP,         1700, 3 },
        { xi.item.WOOL_HAT,         12623, 2 },
        { xi.item.RED_CAP,          20800, 1 },
        { xi.item.SOIL_HACHIMAKI,   13927, 1 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.OREZEBREZ_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
