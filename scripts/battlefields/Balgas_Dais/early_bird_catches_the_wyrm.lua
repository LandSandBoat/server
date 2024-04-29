-----------------------------------
-- Early Bird Catches the Wyrm
-- Balga's Dais KSNM99, Themis Orb
-- !additem 1553
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.EARLY_BIRD_CATCHES_THE_WYRM,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 11,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.THEMIS_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'Wyrm' })

content.loot =
{
    {
        { item = xi.item.JUG_OF_HONEY_WINE, weight = 1000 }, -- Jug Of Honey Wine
    },

    {
        { item = xi.item.LIBATION_ABJURATION, weight = 312 }, -- Libation Abjuration
        { item = xi.item.GUESPIERE,           weight = 182 }, -- Guespiere
        { item = xi.item.HAVOC_SCYTHE,        weight =  65 }, -- Havoc Scythe
        { item = xi.item.LEOPARD_AXE,         weight =  43 }, -- Leopard Axe
        { item = xi.item.NOKIZARU_SHURIKEN,   weight = 181 }, -- Nokizaru Shuriken
        { item = xi.item.SHINSOKU,            weight = 217 }, -- Shinsoku
        { item = xi.item.SOMNUS_SIGNA,        weight =  43 }, -- Somnus Signa
    },

    {
        { item = xi.item.DIVINE_LOG,              weight =  94 }, -- Divine Log
        { item = xi.item.LACQUER_TREE_LOG,        weight = 196 }, -- Lacquer Tree Log
        { item = xi.item.PETRIFIED_LOG,           weight = 572 }, -- Petrified Log
        { item = xi.item.SQUARE_OF_SHINING_CLOTH, weight =  43 }, -- Square Of Shining Cloth
    },

    {
        { item = xi.item.OBLATION_ABJURATION,  weight = 159 }, -- Oblation Abjuration
        { item = xi.item.BAYARDS_SWORD,        weight = 151 }, -- Bayards Sword
        { item = xi.item.DREIZACK,             weight = 167 }, -- Dreizack
        { item = xi.item.GRIM_STAFF,           weight =  95 }, -- Grim Staff
        { item = xi.item.GROSVENEURS_BOW,      weight =  95 }, -- Grosveneurs Bow
        { item = xi.item.STYLET,               weight =  56 }, -- Stylet
        { item = xi.item.UNSHO,                weight = 341 }, -- Unsho
    },

    {
        { item = xi.item.DRAGON_HEART,         weight = 522 }, -- Dragon Heart
        { item = xi.item.SLICE_OF_DRAGON_MEAT, weight = 346 }, -- Slice Of Dragon Meat
        { item = xi.item.JUGGERNAUT,           weight =  82 }, -- Juggernaut
        { item = xi.item.SPEED_BELT,           weight =  59 }, -- Speed Belt
    },

    {
        { item = xi.item.CORAL_FRAGMENT,           weight =  32 }, -- Coral Fragment
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  71 }, -- Chunk Of Darksteel Ore
        { item = xi.item.DEMON_HORN,               weight =  79 }, -- Demon Horn
        { item = xi.item.EBONY_LOG,                weight =  56 }, -- Ebony Log
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight =  71 }, -- Chunk Of Gold Ore
        { item = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  32 }, -- Spool Of Gold Thread
        { item = xi.item.HI_RERAISER,              weight =  48 }, -- Hi-reraiser
        { item = xi.item.MAHOGANY_LOG,             weight = 127 }, -- Mahogany Log
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight = 111 }, -- Chunk Of Mythril Ore
        { item = xi.item.PETRIFIED_LOG,            weight = 183 }, -- Petrified Log
        { item = xi.item.PHILOSOPHERS_STONE,       weight =  40 }, -- Philosophers Stone
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  56 }, -- Chunk Of Platinum Ore
        { item = xi.item.RAM_HORN,                 weight =  24 }, -- Ram Horn
        { item = xi.item.SQUARE_OF_RAXA,           weight = 119 }, -- Square Of Raxa
        { item = xi.item.RERAISER,                 weight =  56 }, -- Reraiser
        { item = xi.item.VILE_ELIXIR_P1,           weight =  40 }, -- Vile Elixir +1
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  24 }, -- Handful Of Wyvern Scales
    },

    {
        { item = xi.item.WYRM_BEARD,          weight = 210 }, -- Wyrm Beard
        { item = xi.item.LOCK_OF_SIRENS_HAIR, weight = 775 }, -- Lock Of Sirens Hair
    },

    {
        { item = xi.item.MIND_POTION,         weight =  94 }, -- Mind Potion
        { item = xi.item.INTELLIGENCE_POTION, weight = 130 }, -- Intelligence Potion
        { item = xi.item.CHARISMA_POTION,     weight = 116 }, -- Charisma Potion
        { item = xi.item.ICARUS_WING,         weight =  51 }, -- Icarus Wing
        { item = xi.item.SQUARE_OF_RAXA,      weight = 246 }, -- Square Of Raxa
        { item = xi.item.PRELATIC_POLE,       weight = 246 }, -- Prelatic Pole
    },

    {
        { item = xi.item.HI_ETHER_P3,    weight = 290 }, -- Hi-ether +3
        { item = xi.item.HI_POTION_P3,   weight = 225 }, -- Hi-potion +3
        { item = xi.item.HI_RERAISER,    weight = 210 }, -- Hi-reraiser
        { item = xi.item.VILE_ELIXIR_P1, weight = 217 }, -- Vile Elixir +1
    },

    {
        { item = xi.item.CORAL_FRAGMENT,           weight =  87 }, -- Coral Fragment
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  80 }, -- Chunk Of Darksteel Ore
        { item = xi.item.DEMON_HORN,               weight =  58 }, -- Demon Horn
        { item = xi.item.EBONY_LOG,                weight =  72 }, -- Ebony Log
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight =  87 }, -- Chunk Of Gold Ore
        { item = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  14 }, -- Spool Of Gold Thread
        { item = xi.item.HI_RERAISER,              weight =  22 }, -- Hi-reraiser
        { item = xi.item.MAHOGANY_LOG,             weight =  80 }, -- Mahogany Log
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  36 }, -- Chunk Of Mythril Ore
        { item = xi.item.PETRIFIED_LOG,            weight = 145 }, -- Petrified Log
        { item = xi.item.PHOENIX_FEATHER,          weight =   7 }, -- Phoenix Feather
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  51 }, -- Chunk Of Platinum Ore
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  29 }, -- Square Of Rainbow Cloth
        { item = xi.item.RAM_HORN,                 weight =  36 }, -- Ram Horn
        { item = xi.item.SQUARE_OF_RAXA,           weight =  72 }, -- Square Of Raxa
        { item = xi.item.RERAISER,                 weight =  29 }, -- Reraiser
        { item = xi.item.VILE_ELIXIR,              weight =  29 }, -- Vile Elixir
        { item = xi.item.VILE_ELIXIR_P1,           weight =   7 }, -- Vile Elixir +1
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  22 }, -- Handful Of Wyvern Scales
    },

    {
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  58 }, -- Vial Of Black Beetle Blood
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  36 }, -- Square Of Damascene Cloth
        { item = xi.item.DAMASCUS_INGOT,             weight =  72 }, -- Damascus Ingot
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  22 }, -- Spool Of Malboro Fiber
        { item = xi.item.PHILOSOPHERS_STONE,         weight = 275 }, -- Philosophers Stone
        { item = xi.item.PHOENIX_FEATHER,            weight = 196 }, -- Phoenix Feather
        { item = xi.item.SQUARE_OF_RAXA,             weight = 225 }, -- Square Of Raxa
    },
}

return content:register()
