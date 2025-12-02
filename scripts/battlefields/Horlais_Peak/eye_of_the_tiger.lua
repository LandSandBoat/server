-----------------------------------
-- Eye of the Tiger
-- Horlais Peak BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.EYE_OF_THE_TIGER,
    maxPlayers       = 3,
    levelCap         = 50,
    timeLimit        = utils.minutes(15),
    index            = 13,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Gerjis' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                      weight = 1000, amount = 8000 }, -- Gil
    },

    {
        quantity = 2,
        { itemId = xi.item.BLACK_TIGER_FANG,         weight = 1000 }, -- Black Tiger Fang
    },

    {
        { itemId = xi.item.NONE,                     weight = 400 }, -- Nothing
        { itemId = xi.item.SLICE_OF_BUFFALO_MEAT,    weight = 200 }, -- Slice of Buffalo Meat
        { itemId = xi.item.SLICE_OF_DRAGON_MEAT,     weight = 200 }, -- Slice of Dragon Meat
        { itemId = xi.item.SLICE_OF_COEURL_MEAT,     weight = 200 }, -- Slice of Coeurl Meat
    },

    {
        { itemId = xi.item.NONE,                     weight = 700 }, -- Nothing
        { itemId = xi.item.NUE_FANG,                 weight = 300 }, -- Nue Fang
    },

    {
        quantity = 2,
        { itemId = xi.item.MANA_CIRCLET,             weight = 62 }, -- Mana Circlet
        { itemId = xi.item.RIVAL_RIBBON,             weight = 62 }, -- Rival Ribbon
        { itemId = xi.item.SHOCK_MASK,               weight = 62 }, -- Shock Mask
        { itemId = xi.item.SUPER_RIBBON,             weight = 62 }, -- Super Ribbon
        { itemId = xi.item.IVORY_MITTS,              weight = 62 }, -- Ivory Mitts
        { itemId = xi.item.RUSH_GLOVES,              weight = 62 }, -- Rush Gloves
        { itemId = xi.item.SLY_GAUNTLETS,            weight = 62 }, -- Sly Gauntlets
        { itemId = xi.item.SPIKED_FINGER_GAUNTLETS,  weight = 62 }, -- Spiked Finger Gauntlets
        { itemId = xi.item.ESOTERIC_MANTLE,          weight = 62 }, -- Esoteric Mantle
        { itemId = xi.item.HEAVY_MANTLE,             weight = 62 }, -- Heavy Mantle
        { itemId = xi.item.SNIPERS_MANTLE,           weight = 62 }, -- Snipers Mantle
        { itemId = xi.item.TEMPLARS_MANTLE,          weight = 62 }, -- Templars Mantle
        { itemId = xi.item.BENIGN_NECKLACE,          weight = 62 }, -- Benign Necklace
        { itemId = xi.item.HATEFUL_COLLAR,           weight = 62 }, -- Hateful Collar
        { itemId = xi.item.INTELLECT_TORQUE,         weight = 62 }, -- Intellect Torque
        { itemId = xi.item.STORM_GORGET,             weight = 62 }, -- Storm Gorget
    },

    {
        { itemId = xi.item.SCROLL_OF_QUAKE,          weight = 62 }, -- Scroll of Quake
        { itemId = xi.item.SCROLL_OF_FREEZE,         weight = 62 }, -- Scroll of Freeze
        { itemId = xi.item.SCROLL_OF_RAISE_II,       weight = 62 }, -- Scroll of Raise II
        { itemId = xi.item.SCROLL_OF_REGEN_III,      weight = 62 }, -- Scroll of Regen III
        { itemId = xi.item.PIECE_OF_WISTERIA_LUMBER, weight = 62 }, -- Piece of Wisteria Lumber
        { itemId = xi.item.MAHOGANY_LOG,             weight = 62 }, -- Mahogany Log
        { itemId = xi.item.EBONY_LOG,                weight = 62 }, -- Ebony Log
        { itemId = xi.item.PETRIFIED_LOG,            weight = 62 }, -- Petrified Log
        { itemId = xi.item.DARKSTEEL_INGOT,          weight = 62 }, -- Darksteel Ingot
        { itemId = xi.item.GOLD_INGOT,               weight = 62 }, -- Gold Ingot
        { itemId = xi.item.MYTHRIL_INGOT,            weight = 62 }, -- Mythril Ingot
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight = 62 }, -- Handful of Wyvern Scales
        { itemId = xi.item.RAM_HORN,                 weight = 62 }, -- Ram Horn
        { itemId = xi.item.WYVERN_SKIN,              weight = 62 }, -- Wyvern Skin
        { itemId = xi.item.RAM_SKIN,                 weight = 62 }, -- Ram Skin
        { itemId = xi.item.CORAL_FRAGMENT,           weight = 62 }, -- Coral Fragment
    }
}

return content:register()
