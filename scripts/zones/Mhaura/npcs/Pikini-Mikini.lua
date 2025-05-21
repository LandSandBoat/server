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
        { xi.item.FLASK_OF_EYE_DROPS,        2698 },
        { xi.item.ANTIDOTE,                   328 },
        { xi.item.FLASK_OF_ECHO_DROPS,        832 },
        { xi.item.POTION,                     946 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
        { xi.item.SHEET_OF_PARCHMENT,        2059 },
        { xi.item.LUGWORM,                     12 },
        { xi.item.HATCHET,                    520 },
        { xi.item.STRIP_OF_MEAT_JERKY,        124 },
        { xi.item.DISH_OF_SALSA,              153 },
        { xi.item.MHAURA_WAYSTONE,          10400 },
    }

    player:showText(npc, zones[xi.zone.MHAURA].text.PIKINIMIKINI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
