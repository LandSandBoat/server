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
        { itemid = xi.item.SUBDUER,        droprate = 222 }, -- Subduer
        { itemid = xi.item.DISSECTOR,      droprate = 302 }, -- Dissector
        { itemid = xi.item.DESTROYERS,     droprate = 245 }, -- Destroyers
        { itemid = xi.item.HEART_SNATCHER, droprate = 208 }, -- Heart Snatcher
    },

    {
        quantity = 2,
        { itemid = xi.item.NONE,                 droprate = 638 }, -- Nothing
        { itemid = xi.item.VIAL_OF_DRAGON_BLOOD, droprate =  10 }, -- Vial Of Dragon Blood
        { itemid = xi.item.DRAGON_HEART,         droprate = 176 }, -- Dragon Heart
        { itemid = xi.item.SLICE_OF_DRAGON_MEAT, droprate = 176 }, -- Slice Of Dragon Meat
    },

    {
        { itemid = xi.item.NONE,        droprate = 392 }, -- Nothing
        { itemid = xi.item.SPEAR_STRAP, droprate = 354 }, -- Spear Strap
        { itemid = xi.item.SWORD_STRAP, droprate = 165 }, -- Sword Strap
        { itemid = xi.item.POLE_GRIP,   droprate =  89 }, -- Pole Grip
    },

    {
        { itemid = xi.item.MINUET_EARRING,   droprate = 586 }, -- Minuet Earring
        { itemid = xi.item.ADAMAN_INGOT,     droprate = 184 }, -- Adaman Ingot
        { itemid = xi.item.ORICHALCUM_INGOT, droprate = 207 }, -- Orichalcum Ingot
    },

    {
        { itemid = xi.item.SORROWFUL_HARP,  droprate = 238 }, -- Sorrowful Harp
        { itemid = xi.item.ATTILAS_EARRING, droprate = 250 }, -- Attilas Earring
        { itemid = xi.item.DURANDAL,        droprate = 225 }, -- Durandal
        { itemid = xi.item.HOPLITES_HARPE,  droprate = 275 }, -- Hoplites Harpe
    },

    {
        { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate = 122 }, -- Chunk Of Gold Ore
        { itemid = xi.item.RERAISER,                 droprate =  54 }, -- Reraiser
        { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  41 }, -- Chunk Of Mythril Ore
        { itemid = xi.item.DEMON_HORN,               droprate =  81 }, -- Demon Horn
        { itemid = xi.item.EBONY_LOG,                droprate = 149 }, -- Ebony Log
        { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  54 }, -- Handful Of Wyvern Scales
        { itemid = xi.item.VILE_ELIXIR_P1,           droprate =  27 }, -- Vile Elixir +1
        { itemid = xi.item.MAHOGANY_LOG,             droprate =  41 }, -- Mahogany Log
        { itemid = xi.item.CORAL_FRAGMENT,           droprate =  95 }, -- Coral Fragment
        { itemid = xi.item.PETRIFIED_LOG,            droprate = 108 }, -- Petrified Log
        { itemid = xi.item.PHOENIX_FEATHER,          droprate = 135 }, -- Phoenix Feather
        { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  54 }, -- Chunk Of Platinum Ore
        { itemid = xi.item.RAM_HORN,                 droprate =  14 }, -- Ram Horn
        { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  14 }, -- Square Of Rainbow Cloth
        { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  68 }, -- Chunk Of Darksteel Ore
        { itemid = xi.item.HI_RERAISER,              droprate =  14 }, -- Hi-reraiser
        { itemid = xi.item.SQUARE_OF_RAXA,           droprate = 135 }, -- Square Of Raxa
    },

    {
        { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  96 }, -- Square Of Damascene Cloth
        { itemid = xi.item.DAMASCUS_INGOT,             droprate =  27 }, -- Damascus Ingot
        { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 164 }, -- Philosophers Stone
        { itemid = xi.item.PHOENIX_FEATHER,            droprate = 260 }, -- Phoenix Feather
        { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  96 }, -- Spool Of Malboro Fiber
        { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 288 }, -- Square Of Raxa
        { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  41 }, -- Vial Of Black Beetle Blood
    },
}

return content:register()
