-----------------------------------
-- Area: Mhaura
--  NPC: Pikini-Mikini
-- !pos -48 -4 30 249
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,        2595 },
        { xi.item.ANTIDOTE,                   316 },
        { xi.item.FLASK_OF_ECHO_DROPS,        800 },
        { xi.item.POTION,                     910 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
        { xi.item.SHEET_OF_PARCHMENT,        1980 },
        { xi.item.LUGWORM,                     12 },
        { xi.item.HATCHET,                    500 },
        { xi.item.STRIP_OF_MEAT_JERKY,        120 },
        { xi.item.DISH_OF_SALSA,              148 },
        { xi.item.MHAURA_WAYSTONE,          10000 },
    }

    player:showText(npc, zones[xi.zone.MHAURA].text.PIKINIMIKINI_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
