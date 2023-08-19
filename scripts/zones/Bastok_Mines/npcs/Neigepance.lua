-----------------------------------
-- Area: Bastok Mines
--  NPC: Neigepance
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.BUNCH_OF_GYSAHL_GREENS,       70, 3,
        xi.items.CHOCOBO_FEATHER,               8, 3,
        xi.items.DART,                         10, 1,
        xi.items.BLACK_CHOCOBO_FEATHER,      1300, 1,
        xi.items.PET_FOOD_ALPHA_BISCUIT,       12, 3,
        xi.items.PET_FOOD_BETA_BISCUIT,        93, 3,
        xi.items.JUG_OF_CARROT_BROTH,          62, 3,
        xi.items.JUG_OF_BUG_BROTH,            101, 3,
        xi.items.JUG_OF_HERBAL_BROTH,         112, 3,
        xi.items.JUG_OF_CARRION_BROTH,        313, 3,
        xi.items.SCROLL_OF_CHOCOBO_MAZURKA, 57408, 3,
    }

    player:showText(npc, ID.text.NEIGEPANCE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
