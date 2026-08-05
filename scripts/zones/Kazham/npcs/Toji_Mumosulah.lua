-----------------------------------
-- Area: Kazham
--  NPC: Toji Mumosulah
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.YELLOW_JAR,                  496 },
        { xi.item.BLOOD_STONE,                 104 },
        { xi.item.FANG_NECKLACE,              3816 },
        { xi.item.BONE_EARRING,               1812 },
        { xi.item.SCROLL_OF_MONOMI_ICHI,      9590 },
        { xi.item.GEMSHORN,                   5160 },
        { xi.item.PEELED_CRAYFISH,              71 },
        { xi.item.BALL_OF_INSECT_PASTE,         40 },
        { xi.item.JUG_OF_FISH_BROTH,            90 },
        { xi.item.JUG_OF_SEEDBED_SOIL,         476 },
        { xi.item.HATCHET,                     500 },
        { xi.item.SCROLL_OF_FOE_LULLABY_II,  70140 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_III,  3600 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.TOJIMUMOSULAH_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
