-----------------------------------
-- Area: Port Jeuno
--  NPC: Leyla
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HAWKEYE,                      60 },
        { xi.item.IRON_ARROW,                    8 },
        { xi.item.CROSSBOW_BOLT,                 6 },
        { xi.item.SCROLL_OF_SINEWY_ETUDE,     3420 },
        { xi.item.SCROLL_OF_DEXTROUS_ETUDE,   3060 },
        { xi.item.SCROLL_OF_VIVACIOUS_ETUDE,  2400 },
        { xi.item.SCROLL_OF_QUICK_ETUDE,      2080 },
        { xi.item.SCROLL_OF_LEARNED_ETUDE,    1704 },
        { xi.item.SCROLL_OF_SPIRITED_ETUDE,   1376 },
        { xi.item.SCROLL_OF_ENCHANTING_ETUDE, 1088 },
        { xi.item.FLASK_OF_DISTILLED_WATER,     12 },
    }

    player:showText(npc, zones[xi.zone.PORT_JEUNO].text.DUTY_FREE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
