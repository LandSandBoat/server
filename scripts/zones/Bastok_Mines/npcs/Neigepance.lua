-----------------------------------
-- Area: Bastok Mines
--  NPC: Neigepance
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BUNCH_OF_GYSAHL_GREENS,       70, 3,
        xi.item.CHOCOBO_FEATHER,               8, 3,
        xi.item.DART,                         10, 1,
        xi.item.BLACK_CHOCOBO_FEATHER,      1300, 1,
        xi.item.PET_FOOD_ALPHA_BISCUIT,       12, 3,
        xi.item.PET_FOOD_BETA_BISCUIT,        93, 3,
        xi.item.JUG_OF_CARROT_BROTH,          62, 3,
        xi.item.JUG_OF_BUG_BROTH,            101, 3,
        xi.item.JUG_OF_HERBAL_BROTH,         112, 3,
        xi.item.JUG_OF_CARRION_BROTH,        313, 3,
        xi.item.SCROLL_OF_CHOCOBO_MAZURKA, 57408, 3,
    }

    player:showText(npc, ID.text.NEIGEPANCE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
