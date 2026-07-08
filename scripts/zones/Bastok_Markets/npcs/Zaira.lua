-----------------------------------
-- Area: Batok Markets
--  NPC: Zaira
-- !pos -217.316 -2.824 49.235 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_STONE,      71, 3 },
        { xi.item.SCROLL_OF_WATER,     163, 3 },
        { xi.item.SCROLL_OF_AERO,      378, 3 },
        { xi.item.SCROLL_OF_FIRE,      976, 3 },
        { xi.item.SCROLL_OF_BLIZZARD, 1848, 3 },
        { xi.item.SCROLL_OF_THUNDER,  3805, 3 },
        { xi.item.SCROLL_OF_POISON,     96, 2 },
        { xi.item.SCROLL_OF_BIO,       420, 2 },
        { xi.item.SCROLL_OF_BLIND,     128, 1 },
        { xi.item.SCROLL_OF_SLEEP,    2625, 2 },
        { xi.item.SCROLL_OF_BURN,     5418, 3 },
        { xi.item.SCROLL_OF_FROST,    4302, 3 },
        { xi.item.SCROLL_OF_CHOKE,    2625, 3 },
        { xi.item.SCROLL_OF_RASP,     2131, 3 },
        { xi.item.SCROLL_OF_SHOCK,    1590, 3 },
        { xi.item.SCROLL_OF_DROWN,    7427, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.ZAIRA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
