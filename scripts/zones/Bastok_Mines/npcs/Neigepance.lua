-----------------------------------
-- Area: Bastok Mines
--  NPC: Neigepance
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS,       68, 3 },
        { xi.item.CHOCOBO_FEATHER,               8, 3 },
        { xi.item.DART,                         10, 1 },
        { xi.item.BLACK_CHOCOBO_FEATHER,      1239, 1 },
        { xi.item.PET_FOOD_ALPHA_BISCUIT,       12, 3 },
        { xi.item.PET_FOOD_BETA_BISCUIT,        90, 3 },
        { xi.item.JUG_OF_CARROT_BROTH,          60, 3 },
        { xi.item.JUG_OF_BUG_BROTH,            98, 3 },
        { xi.item.JUG_OF_HERBAL_BROTH,         108, 3 },
        { xi.item.JUG_OF_CARRION_BROTH,        301, 3 },
        { xi.item.SCROLL_OF_CHOCOBO_MAZURKA, 55200, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.NEIGEPANCE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
