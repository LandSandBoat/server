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
        { xi.item.GEMSHORN,                      5416, 3 },
        { xi.item.CORNETTE,                       256, 2 },
        { xi.item.FLUTE,                           50, 3 },
        { xi.item.PICCOLO,                       1144, 1 },
        { xi.item.MAPLE_HARP,                      50, 2 },
        { xi.item.SCROLL_OF_VITAL_ETUDE,        80640, 2 },
        { xi.item.SCROLL_OF_SWIFT_ETUDE,        77280, 2 },
        { xi.item.SCROLL_OF_SAGE_ETUDE,         73920, 2 },
        { xi.item.SCROLL_OF_LOGICAL_ETUDE,      66150, 2 },
        { xi.item.SCROLL_OF_BEWITCHING_ETUDE,   63000, 3 },
        { xi.item.SCROLL_OF_HERCULEAN_ETUDE,    92820, 2 },
        { xi.item.SCROLL_OF_UNCANNY_ETUDE,      89250, 2 },
        { xi.item.SCROLL_OF_FOE_SIRVENTE,      104343, 3 },
        { xi.item.SCROLL_OF_ADVENTURERS_DIRGE, 104343, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.HARMODIOS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
