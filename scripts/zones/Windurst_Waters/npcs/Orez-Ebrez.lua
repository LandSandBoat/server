-----------------------------------
-- Area: Windurst Waters
--  NPC: Orez-Ebrez
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HEADGEAR,          1936, 3 },
        { xi.item.CIRCLET,            160, 2 },
        { xi.item.POETS_CIRCLET,     2070, 2 },
        { xi.item.HACHIMAKI,          825, 3 },
        { xi.item.COTTON_HEADBAND,   2000, 3 },
        { xi.item.BRONZE_CAP,         168, 3 },
        { xi.item.COTTON_HEADGEAR,   8918, 2 },
        { xi.item.LEATHER_BANDANA,    440, 2 },
        { xi.item.WINDSHEAR_HAT,      750, 3 },
        { xi.item.FLAX_HEADBAND,    16000, 2 },
        { xi.item.COTTON_HACHIMAKI,  4884, 2 },
        { xi.item.BRASS_CAP,         1635, 3 },
        { xi.item.WOOL_HAT,         12138, 2 },
        { xi.item.RED_CAP,          20000, 1 },
        { xi.item.SOIL_HACHIMAKI,   13392, 1 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.OREZEBREZ_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
