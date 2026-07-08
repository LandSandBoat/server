-----------------------------------
-- Area: Port Windurst
--  NPC: Aroro
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_STONE,      70, 3 },
        { xi.item.SCROLL_OF_WATER,     162, 3 },
        { xi.item.SCROLL_OF_AERO,      374, 3 },
        { xi.item.SCROLL_OF_FIRE,      967, 3 },
        { xi.item.SCROLL_OF_BLIZZARD, 1830, 3 },
        { xi.item.SCROLL_OF_THUNDER,  3768, 3 },
        { xi.item.SCROLL_OF_POISON,     95, 2 },
        { xi.item.SCROLL_OF_BIO,       416, 2 },
        { xi.item.SCROLL_OF_BLIND,     128, 1 },
        { xi.item.SCROLL_OF_SLEEP,    2600, 2 },
        { xi.item.SCROLL_OF_BURN,     5366, 3 },
        { xi.item.SCROLL_OF_FROST,    4261, 3 },
        { xi.item.SCROLL_OF_CHOKE,    2600, 3 },
        { xi.item.SCROLL_OF_RASP,     2111, 3 },
        { xi.item.SCROLL_OF_SHOCK,    1575, 3 },
        { xi.item.SCROLL_OF_DROWN,    7356, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.ARORO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
