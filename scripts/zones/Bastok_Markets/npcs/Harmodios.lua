-----------------------------------
-- Area: Bastok Markets
--  NPC: Harmodios
-- !pos -79.928 -4.824 -135.114 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.GEMSHORN,                      5159, 3 },
        { xi.item.CORNETTE,                       244, 2 },
        { xi.item.FLUTE,                           49, 3 },
        { xi.item.PICCOLO,                       1090, 1 },
        { xi.item.MAPLE_HARP,                      49, 2 },
        { xi.item.SCROLL_OF_VITAL_ETUDE,        76800, 2 },
        { xi.item.SCROLL_OF_SWIFT_ETUDE,        73600, 2 },
        { xi.item.SCROLL_OF_SAGE_ETUDE,         70400, 2 },
        { xi.item.SCROLL_OF_LOGICAL_ETUDE,      63000, 2 },
        { xi.item.SCROLL_OF_BEWITCHING_ETUDE,   60000, 3 },
        { xi.item.SCROLL_OF_HERCULEAN_ETUDE,    88400, 2 },
        { xi.item.SCROLL_OF_UNCANNY_ETUDE,      85000, 2 },
        { xi.item.SCROLL_OF_FOE_SIRVENTE,      99375, 3 },
        { xi.item.SCROLL_OF_ADVENTURERS_DIRGE, 99375, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.HARMODIOS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
