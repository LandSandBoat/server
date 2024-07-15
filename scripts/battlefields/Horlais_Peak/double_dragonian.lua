-----------------------------------
-- Double Dragonian
-- Horlais Peak KSNM, Clotho Orb
-- !additem 1175
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.DOUBLE_DRAGONIAN,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 15,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOTHO_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Dragonian_Berzerker', 'Dragonian_Minstrel' })

content.loot =
{
    {
        { item = xi.item.SUBDUER,        weight = 222 }, -- Subduer
        { item = xi.item.DISSECTOR,      weight = 302 }, -- Dissector
        { item = xi.item.DESTROYERS,     weight = 245 }, -- Destroyers
        { item = xi.item.HEART_SNATCHER, weight = 208 }, -- Heart Snatcher
    },

    {
        quantity = 2,
        { item = xi.item.NONE,                 weight = 638 }, -- Nothing
        { item = xi.item.VIAL_OF_DRAGON_BLOOD, weight =  10 }, -- Vial Of Dragon Blood
        { item = xi.item.DRAGON_HEART,         weight = 176 }, -- Dragon Heart
        { item = xi.item.SLICE_OF_DRAGON_MEAT, weight = 176 }, -- Slice Of Dragon Meat
    },

    {
        { item = xi.item.NONE,        weight = 392 }, -- Nothing
        { item = xi.item.SPEAR_STRAP, weight = 354 }, -- Spear Strap
        { item = xi.item.SWORD_STRAP, weight = 165 }, -- Sword Strap
        { item = xi.item.POLE_GRIP,   weight =  89 }, -- Pole Grip
    },

    {
        { item = xi.item.MINUET_EARRING,   weight = 586 }, -- Minuet Earring
        { item = xi.item.ADAMAN_INGOT,     weight = 184 }, -- Adaman Ingot
        { item = xi.item.ORICHALCUM_INGOT, weight = 207 }, -- Orichalcum Ingot
    },

    {
        { item = xi.item.SORROWFUL_HARP,  weight = 238 }, -- Sorrowful Harp
        { item = xi.item.ATTILAS_EARRING, weight = 250 }, -- Attilas Earring
        { item = xi.item.DURANDAL,        weight = 225 }, -- Durandal
        { item = xi.item.HOPLITES_HARPE,  weight = 275 }, -- Hoplites Harpe
    },

    {
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight = 122 }, -- Chunk Of Gold Ore
        { item = xi.item.RERAISER,                 weight =  54 }, -- Reraiser
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  41 }, -- Chunk Of Mythril Ore
        { item = xi.item.DEMON_HORN,               weight =  81 }, -- Demon Horn
        { item = xi.item.EBONY_LOG,                weight = 149 }, -- Ebony Log
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  54 }, -- Handful Of Wyvern Scales
        { item = xi.item.VILE_ELIXIR_P1,           weight =  27 }, -- Vile Elixir +1
        { item = xi.item.MAHOGANY_LOG,             weight =  41 }, -- Mahogany Log
        { item = xi.item.CORAL_FRAGMENT,           weight =  95 }, -- Coral Fragment
        { item = xi.item.PETRIFIED_LOG,            weight = 108 }, -- Petrified Log
        { item = xi.item.PHOENIX_FEATHER,          weight = 135 }, -- Phoenix Feather
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  54 }, -- Chunk Of Platinum Ore
        { item = xi.item.RAM_HORN,                 weight =  14 }, -- Ram Horn
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  14 }, -- Square Of Rainbow Cloth
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  68 }, -- Chunk Of Darksteel Ore
        { item = xi.item.HI_RERAISER,              weight =  14 }, -- Hi-reraiser
        { item = xi.item.SQUARE_OF_RAXA,           weight = 135 }, -- Square Of Raxa
    },

    {
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  96 }, -- Square Of Damascene Cloth
        { item = xi.item.DAMASCUS_INGOT,             weight =  27 }, -- Damascus Ingot
        { item = xi.item.PHILOSOPHERS_STONE,         weight = 164 }, -- Philosophers Stone
        { item = xi.item.PHOENIX_FEATHER,            weight = 260 }, -- Phoenix Feather
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  96 }, -- Spool Of Malboro Fiber
        { item = xi.item.SQUARE_OF_RAXA,             weight = 288 }, -- Square Of Raxa
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  41 }, -- Vial Of Black Beetle Blood
    },
}

return content:register()
