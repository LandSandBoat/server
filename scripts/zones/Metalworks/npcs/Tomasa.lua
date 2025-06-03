-----------------------------------
-- Area: Metalworks
--  NPC: Tomasa
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -13, y = -10, z = -19, rotation = 0, wait = 4000 },
    { z = -29, rotation = 0, wait = 4000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LOAF_OF_IRON_BREAD,         105, 3 },
        { xi.item.BRETZEL,                     25, 2 },
        { xi.item.SAUSAGE_ROLL,               291, 1 },
        { xi.item.BAKED_POPOTO,               336, 3 },
        { xi.item.SAUSAGE,                    163, 2 },
        { xi.item.HARD_BOILED_EGG,             83, 1 },
        { xi.item.BOWL_OF_PEBBLE_SOUP,        210, 3 },
        { xi.item.BOWL_OF_EGG_SOUP,          3432, 1 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12, 3 },
        { xi.item.BOTTLE_OF_MELON_JUICE,     1155, 2 },
        { xi.item.BOTTLE_OF_PINEAPPLE_JUICE,  416, 1 },
    }

    player:showText(npc, zones[xi.zone.METALWORKS].text.TOMASA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
