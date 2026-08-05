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
        { xi.item.SCROLL_OF_STONE,      68, 3 },
        { xi.item.SCROLL_OF_WATER,     156, 3 },
        { xi.item.SCROLL_OF_AERO,      360, 3 },
        { xi.item.SCROLL_OF_FIRE,      930, 3 },
        { xi.item.SCROLL_OF_BLIZZARD, 1760, 3 },
        { xi.item.SCROLL_OF_THUNDER,  3624, 3 },
        { xi.item.SCROLL_OF_POISON,     91, 2 },
        { xi.item.SCROLL_OF_BIO,       400, 2 },
        { xi.item.SCROLL_OF_BLIND,     122, 1 },
        { xi.item.SCROLL_OF_SLEEP,    2500, 2 },
        { xi.item.SCROLL_OF_BURN,     5160, 3 },
        { xi.item.SCROLL_OF_FROST,    4098, 3 },
        { xi.item.SCROLL_OF_CHOKE,    2500, 3 },
        { xi.item.SCROLL_OF_RASP,     2030, 3 },
        { xi.item.SCROLL_OF_SHOCK,    1515, 3 },
        { xi.item.SCROLL_OF_DROWN,    7074, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.ZAIRA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
