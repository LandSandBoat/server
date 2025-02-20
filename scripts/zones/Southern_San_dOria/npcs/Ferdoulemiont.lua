-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ferdoulemiont
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 10.886, y = 2.200, z = -95.739, rotation = 224, wait = 8000 },
    { rotation =   0, wait = 8000 },
    { rotation = 224, wait = 8000 },
    { rotation = 192, wait = 8000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BUNCH_OF_GYSAHL_GREENS,         70, 3,
        xi.item.CHOCOBO_FEATHER,                 8, 3,
        xi.item.SCROLL_OF_KNIGHTS_MINNE,        18, 3,
        xi.item.SCROLL_OF_KNIGHTS_MINNE_II,    998, 3,
        xi.item.SCROLL_OF_KNIGHTS_MINNE_III,  5948, 3,
        xi.item.SCROLL_OF_KNIGHTS_MINNE_V,   57304, 3,
        xi.item.DART,                           10, 2,
        xi.item.BLACK_CHOCOBO_FEATHER,        1300, 1,
        xi.item.PET_FOOD_ALPHA_BISCUIT,         12, 3,
        xi.item.PET_FOOD_BETA_BISCUIT,          93, 3,
        xi.item.JUG_OF_CARROT_BROTH,            62, 3,
        xi.item.JUG_OF_BUG_BROTH,              101, 3,
        xi.item.JUG_OF_HERBAL_BROTH,           112, 3,
        xi.item.JUG_OF_CARRION_BROTH,          313, 3,
        xi.item.SCROLL_OF_CHOCOBO_MAZURKA,   57408, 3,
        xi.item.LA_THEINE_MILLET,             2293, 3,
    }

    player:showText(npc, ID.text.FERDOULEMIONT_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
