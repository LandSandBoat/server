-----------------------------------
-- Area: Al Zahbi
--  NPC: Chayaya
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.DART,                10, },
        { xi.item.HAWKEYE,             60, },
        { xi.item.GRENADE,           1204, },
        { xi.item.IRON_ARROW,           8, },
        { xi.item.WARRIOR_DIE,      68000, },
        { xi.item.MONK_DIE,         22400, },
        { xi.item.WHITE_MAGE_DIE,    5000, },
        { xi.item.BLACK_MAGE_DIE,  108000, },
        { xi.item.RED_MAGE_DIE,     62000, },
        { xi.item.THIEF_DIE,        50400, },
        { xi.item.PALADIN_DIE,      90750, },
        { xi.item.DARK_KNIGHT_DIE,   2205, },
        { xi.item.BEASTMASTER_DIE,  26600, },
        { xi.item.BARD_DIE,         12780, },
        { xi.item.RANGER_DIE,        1300, },
        { xi.item.DANCER_DIE,       63375, },
        { xi.item.SCHOLAR_DIE,      68250, },
    }

    player:showText(npc, ID.text.CHAYAYA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
