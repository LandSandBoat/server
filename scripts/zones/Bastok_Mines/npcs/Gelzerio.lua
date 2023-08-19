-----------------------------------
-- Area: Bastok Mines
--  NPC: Galzerio
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
        xi.items.LUGWORM,              12, 3,
        xi.items.LITTLE_WORM,           4, 2,
        xi.items.BAMBOO_FISHING_ROD,  561, 1,
        xi.items.YEW_FISHING_ROD,     245, 2,
        xi.items.WILLOW_FISHING_ROD,   74, 3,
        xi.items.ROBE,                249, 3,
        xi.items.CUFFS,               137, 3,
        xi.items.SLOPS,               199, 3,
        xi.items.ASH_CLOGS,           128, 3,
        xi.items.HEADGEAR,           2013, 3,
        xi.items.DOUBLET,            2854, 3,
        xi.items.GLOVES,             1575, 3,
        xi.items.BRAIS,              2194, 3,
        xi.items.GAITERS,            1466, 3,
    }

    player:showText(npc, ID.text.GELZERIO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
