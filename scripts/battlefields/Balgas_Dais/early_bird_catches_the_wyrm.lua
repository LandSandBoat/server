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
        { itemId = xi.item.GIL, weight = 1000, amount = 32000 }, -- Gil
    },

    {
        { itemId = xi.item.JUG_OF_HONEY_WINE, weight = 1000 }, -- Jug Of Honey Wine
    },

    {
        { itemId = xi.item.LIBATION_ABJURATION, weight = 312 }, -- Libation Abjuration
        { itemId = xi.item.GUESPIERE,           weight = 182 }, -- Guespiere
        { itemId = xi.item.HAVOC_SCYTHE,        weight =  65 }, -- Havoc Scythe
        { itemId = xi.item.LEOPARD_AXE,         weight =  43 }, -- Leopard Axe
        { itemId = xi.item.NOKIZARU_SHURIKEN,   weight = 181 }, -- Nokizaru Shuriken
        { itemId = xi.item.SHINSOKU,            weight = 217 }, -- Shinsoku
        { itemId = xi.item.SOMNUS_SIGNA,        weight =  43 }, -- Somnus Signa
    },

    {
        { itemId = xi.item.DIVINE_LOG,              weight =  94 }, -- Divine Log
        { itemId = xi.item.LACQUER_TREE_LOG,        weight = 196 }, -- Lacquer Tree Log
        { itemId = xi.item.PETRIFIED_LOG,           weight = 572 }, -- Petrified Log
        { itemId = xi.item.SQUARE_OF_SHINING_CLOTH, weight =  43 }, -- Square Of Shining Cloth
    },

    {
        { itemId = xi.item.OBLATION_ABJURATION,  weight = 159 }, -- Oblation Abjuration
        { itemId = xi.item.BAYARDS_SWORD,        weight = 151 }, -- Bayards Sword
        { itemId = xi.item.DREIZACK,             weight = 167 }, -- Dreizack
        { itemId = xi.item.GRIM_STAFF,           weight =  95 }, -- Grim Staff
        { itemId = xi.item.GROSVENEURS_BOW,      weight =  95 }, -- Grosveneurs Bow
        { itemId = xi.item.STYLET,               weight =  56 }, -- Stylet
        { itemId = xi.item.UNSHO,                weight = 341 }, -- Unsho
    },

    {
        { itemId = xi.item.DRAGON_HEART,         weight = 522 }, -- Dragon Heart
        { itemId = xi.item.SLICE_OF_DRAGON_MEAT, weight = 346 }, -- Slice Of Dragon Meat
        { itemId = xi.item.JUGGERNAUT,           weight =  82 }, -- Juggernaut
        { itemId = xi.item.SPEED_BELT,           weight =  59 }, -- Speed Belt
    },

    {
        { itemId = xi.item.CORAL_FRAGMENT,           weight =  32 }, -- Coral Fragment
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  71 }, -- Chunk Of Darksteel Ore
        { itemId = xi.item.DEMON_HORN,               weight =  79 }, -- Demon Horn
        { itemId = xi.item.EBONY_LOG,                weight =  56 }, -- Ebony Log
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight =  71 }, -- Chunk Of Gold Ore
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  32 }, -- Spool Of Gold Thread
        { itemId = xi.item.HI_RERAISER,              weight =  48 }, -- Hi-reraiser
        { itemId = xi.item.MAHOGANY_LOG,             weight = 127 }, -- Mahogany Log
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight = 111 }, -- Chunk Of Mythril Ore
        { itemId = xi.item.PETRIFIED_LOG,            weight = 183 }, -- Petrified Log
        { itemId = xi.item.PHILOSOPHERS_STONE,       weight =  40 }, -- Philosophers Stone
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  56 }, -- Chunk Of Platinum Ore
        { itemId = xi.item.RAM_HORN,                 weight =  24 }, -- Ram Horn
        { itemId = xi.item.SQUARE_OF_RAXA,           weight = 119 }, -- Square Of Raxa
        { itemId = xi.item.RERAISER,                 weight =  56 }, -- Reraiser
        { itemId = xi.item.VILE_ELIXIR_P1,           weight =  40 }, -- Vile Elixir +1
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  24 }, -- Handful Of Wyvern Scales
    },

    {
        { itemId = xi.item.WYRM_BEARD,          weight = 210 }, -- Wyrm Beard
        { itemId = xi.item.LOCK_OF_SIRENS_HAIR, weight = 775 }, -- Lock Of Sirens Hair
    },

    {
        { itemId = xi.item.MIND_POTION,         weight =  94 }, -- Mind Potion
        { itemId = xi.item.INTELLIGENCE_POTION, weight = 130 }, -- Intelligence Potion
        { itemId = xi.item.CHARISMA_POTION,     weight = 116 }, -- Charisma Potion
        { itemId = xi.item.ICARUS_WING,         weight =  51 }, -- Icarus Wing
        { itemId = xi.item.SQUARE_OF_RAXA,      weight = 246 }, -- Square Of Raxa
        { itemId = xi.item.PRELATIC_POLE,       weight = 246 }, -- Prelatic Pole
    },

    {
        { itemId = xi.item.HI_ETHER_P3,    weight = 290 }, -- Hi-ether +3
        { itemId = xi.item.HI_POTION_P3,   weight = 225 }, -- Hi-potion +3
        { itemId = xi.item.HI_RERAISER,    weight = 210 }, -- Hi-reraiser
        { itemId = xi.item.VILE_ELIXIR_P1, weight = 217 }, -- Vile Elixir +1
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  58 }, -- Vial Of Black Beetle Blood
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  36 }, -- Square Of Damascene Cloth
        { itemId = xi.item.DAMASCUS_INGOT,             weight =  72 }, -- Damascus Ingot
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  22 }, -- Spool Of Malboro Fiber
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight = 275 }, -- Philosophers Stone
        { itemId = xi.item.PHOENIX_FEATHER,            weight = 196 }, -- Phoenix Feather
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 225 }, -- Square Of Raxa
    },
}

return content:register()
