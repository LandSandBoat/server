-----------------------------------
-- The Hills are Alive
-- Waughroon Shrine KSNM99, Themis Orb
-- !additem 1553
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.HILLS_ARE_ALIVE,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 12,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.THEMIS_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED }
})

content:addEssentialMobs({ 'Tartaruga_Gigante' })

content.loot =
{
    {
        { itemId = xi.item.GIL, weight = 1000, amount = 32000 }, -- Gil
    },

    {
        { itemId = xi.item.CLUMP_OF_BLUE_PONDWEED, weight = 1000 }, -- Blue Pondweed
    },

    {
        { itemId = xi.item.HAVOC_SCYTHE,        weight = 188 }, -- Havoc Scythe
        { itemId = xi.item.KRIEGSBEIL,          weight =  27 }, -- Kriegsbeil
        { itemId = xi.item.LEOPARD_AXE,         weight = 170 }, -- Leopard Axe
        { itemId = xi.item.LIBATION_ABJURATION, weight = 295 }, -- Libation Abjuration
        { itemId = xi.item.METEOR_CESTI,        weight =  27 }, -- Meteor Cesti
        { itemId = xi.item.PURGATORY_MACE,      weight =  71 }, -- Purgatory Mace
        { itemId = xi.item.SOMNUS_SIGNA,        weight = 196 }, -- Somnus Signa
    },

    {
        { itemId = xi.item.GAWAINS_AXE,         weight =  45 }, -- Gawains Axe
        { itemId = xi.item.GRIM_STAFF,          weight = 259 }, -- Grim Staff
        { itemId = xi.item.GROSVENEURS_BOW,     weight = 241 }, -- Grosveneurs Bow
        { itemId = xi.item.HARLEQUINS_HORN,     weight = 143 }, -- Harlequins Horn
        { itemId = xi.item.OBLATION_ABJURATION, weight = 161 }, -- Oblation Abjuration
        { itemId = xi.item.STYLET,              weight = 143 }, -- Stylet
        { itemId = xi.item.ZEN_POLE,            weight =  36 }, -- Zen Pole
    },

    {
        { itemId = xi.item.ADAMAN_CHAIN,        weight = 446 }, -- Adaman Chain
        { itemId = xi.item.ADAMANTOISE_SHELL,   weight = 420 }, -- Adamantoise Shell
        { itemId = xi.item.PIECE_OF_ANGEL_SKIN, weight =  71 }, -- Piece Of Angel Skin
        { itemId = xi.item.STRIDER_BOOTS,       weight =  26 }, -- Strider Boots
    },

    {
        { itemId = xi.item.CORAL_FRAGMENT,           weight = 116 }, -- Coral Fragment
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  89 }, -- Chunk Of Darksteel Ore
        { itemId = xi.item.DEMON_HORN,               weight =  71 }, -- Demon Horn
        { itemId = xi.item.EBONY_LOG,                weight = 152 }, -- Ebony Log
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight = 107 }, -- Chunk Of Gold Ore
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  89 }, -- Spool Of Gold Thread
        { itemId = xi.item.SLAB_OF_GRANITE,          weight =  45 }, -- Slab Of Granite
        { itemId = xi.item.HI_RERAISER,              weight =  71 }, -- Hi-reraiser
        { itemId = xi.item.MAHOGANY_LOG,             weight = 107 }, -- Mahogany Log
        { itemId = xi.item.PETRIFIED_LOG,            weight = 223 }, -- Petrified Log
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight = 116 }, -- Chunk Of Platinum Ore
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  54 }, -- Square Of Rainbow Cloth
        { itemId = xi.item.RAM_HORN,                 weight =  54 }, -- Ram Horn
        { itemId = xi.item.SQUARE_OF_RAXA,           weight =  71 }, -- Square Of Raxa
        { itemId = xi.item.RERAISER,                 weight =  45 }, -- Reraiser
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  54 }, -- Handful Of Wyvern Scales
        { itemId = xi.item.VILE_ELIXIR,              weight =  63 }, -- Vile Elixir
        { itemId = xi.item.VILE_ELIXIR_P1,           weight =  45 }, -- Vile Elixir +1
    },

    {
        { itemId = xi.item.ADAMAN_CHAIN,     weight = 268 }, -- Adaman Chain
        { itemId = xi.item.ADAMANTOISE_EGG,  weight = 121 }, -- Adamantoise Egg
        { itemId = xi.item.AGILITY_POTION,   weight =  80 }, -- Agility Potion
        { itemId = xi.item.DEXTERITY_POTION, weight = 143 }, -- Dexterity Potion
        { itemId = xi.item.STRENGTH_POTION,  weight = 214 }, -- Strength Potion
        { itemId = xi.item.VITALITY_POTION,  weight = 196 }, -- Vitality Potion
    },

    {
        { itemId = xi.item.CHUNK_OF_ADAMAN_ORE,     weight = 107 }, -- Chunk Of Adaman Ore
        { itemId = xi.item.CHARISMA_POTION,         weight =  89 }, -- Charisma Potion
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight = 179 }, -- Chunk Of Darksteel Ore
        { itemId = xi.item.ICARUS_WING,             weight = 134 }, -- Icarus Wing
        { itemId = xi.item.INTELLIGENCE_POTION,     weight = 152 }, -- Intelligence Potion
        { itemId = xi.item.MIND_POTION,             weight =  80 }, -- Mind Potion
        { itemId = xi.item.CHUNK_OF_ORICHALCUM_ORE, weight =  80 }, -- Chunk Of Orichalcum Ore
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,   weight = 107 }, -- Chunk Of Platinum Ore
        { itemId = xi.item.PRINCELY_SWORD,          weight = 152 }, -- Princely Sword
    },

    {
        { itemId = xi.item.HI_ETHER_P3,    weight = 295 },  -- Hi-ether +3
        { itemId = xi.item.HI_POTION_P3,   weight = 250 },  -- Hi-potion +3
        { itemId = xi.item.HI_RERAISER,    weight = 196 },  -- Hi-reraiser
        { itemId = xi.item.VILE_ELIXIR_P1, weight = 214 },  -- Vile Elixir +1
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight = 109 }, -- Vial Of Black Beetle Blood
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  89 }, -- Square Of Damascene Cloth
        { itemId = xi.item.DAMASCUS_INGOT,             weight =  79 }, -- Damascus Ingot
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  99 }, -- Spool Of Malboro Fiber
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight = 188 }, -- Philosophers Stone
        { itemId = xi.item.PHOENIX_FEATHER,            weight = 238 }, -- Phoenix Feather
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 109 }, -- Square Of Raxa
    },

    {
        { itemId = xi.item.DIVINE_LOG,              weight =  79 }, -- Divine Log
        { itemId = xi.item.LACQUER_TREE_LOG,        weight = 257 }, -- Lacquer Tree Log
        { itemId = xi.item.PETRIFIED_LOG,           weight = 337 }, -- Petrified Log
        { itemId = xi.item.SQUARE_OF_SHINING_CLOTH, weight = 149 }, -- Square Of Shining Cloth
    },
}

return content:register()
