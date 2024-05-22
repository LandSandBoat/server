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
    requiredItems    = { xi.item.THEMIS_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'Tartaruga_Gigante' })

content.loot =
{
    {
        { item = xi.item.CLUMP_OF_BLUE_PONDWEED, weight = 1000 }, -- Blue Pondweed
    },

    {
        { item = xi.item.HAVOC_SCYTHE,        weight = 188 }, -- Havoc Scythe
        { item = xi.item.KRIEGSBEIL,          weight =  27 }, -- Kriegsbeil
        { item = xi.item.LEOPARD_AXE,         weight = 170 }, -- Leopard Axe
        { item = xi.item.LIBATION_ABJURATION, weight = 295 }, -- Libation Abjuration
        { item = xi.item.METEOR_CESTI,        weight =  27 }, -- Meteor Cesti
        { item = xi.item.PURGATORY_MACE,      weight =  71 }, -- Purgatory Mace
        { item = xi.item.SOMNUS_SIGNA,        weight = 196 }, -- Somnus Signa
    },

    {
        { item = xi.item.GAWAINS_AXE,         weight =  45 }, -- Gawains Axe
        { item = xi.item.GRIM_STAFF,          weight = 259 }, -- Grim Staff
        { item = xi.item.GROSVENEURS_BOW,     weight = 241 }, -- Grosveneurs Bow
        { item = xi.item.HARLEQUINS_HORN,     weight = 143 }, -- Harlequins Horn
        { item = xi.item.OBLATION_ABJURATION, weight = 161 }, -- Oblation Abjuration
        { item = xi.item.STYLET,              weight = 143 }, -- Stylet
        { item = xi.item.ZEN_POLE,            weight =  36 }, -- Zen Pole
    },

    {
        { item = xi.item.ADAMAN_CHAIN,        weight = 446 }, -- Adaman Chain
        { item = xi.item.ADAMANTOISE_SHELL,   weight = 420 }, -- Adamantoise Shell
        { item = xi.item.PIECE_OF_ANGEL_SKIN, weight =  71 }, -- Piece Of Angel Skin
        { item = xi.item.STRIDER_BOOTS,       weight =  26 }, -- Strider Boots
    },

    {
        { item = xi.item.CORAL_FRAGMENT,           weight = 116 }, -- Coral Fragment
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  89 }, -- Chunk Of Darksteel Ore
        { item = xi.item.DEMON_HORN,               weight =  71 }, -- Demon Horn
        { item = xi.item.EBONY_LOG,                weight = 152 }, -- Ebony Log
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight = 107 }, -- Chunk Of Gold Ore
        { item = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  89 }, -- Spool Of Gold Thread
        { item = xi.item.SLAB_OF_GRANITE,          weight =  45 }, -- Slab Of Granite
        { item = xi.item.HI_RERAISER,              weight =  71 }, -- Hi-reraiser
        { item = xi.item.MAHOGANY_LOG,             weight = 107 }, -- Mahogany Log
        { item = xi.item.PETRIFIED_LOG,            weight = 223 }, -- Petrified Log
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight = 116 }, -- Chunk Of Platinum Ore
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  54 }, -- Square Of Rainbow Cloth
        { item = xi.item.RAM_HORN,                 weight =  54 }, -- Ram Horn
        { item = xi.item.SQUARE_OF_RAXA,           weight =  71 }, -- Square Of Raxa
        { item = xi.item.RERAISER,                 weight =  45 }, -- Reraiser
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  54 }, -- Handful Of Wyvern Scales
        { item = xi.item.VILE_ELIXIR,              weight =  63 }, -- Vile Elixir
        { item = xi.item.VILE_ELIXIR_P1,           weight =  45 }, -- Vile Elixir +1
    },

    {
        { item = xi.item.ADAMAN_CHAIN,     weight = 268 }, -- Adaman Chain
        { item = xi.item.ADAMANTOISE_EGG,  weight = 121 }, -- Adamantoise Egg
        { item = xi.item.AGILITY_POTION,   weight =  80 }, -- Agility Potion
        { item = xi.item.DEXTERITY_POTION, weight = 143 }, -- Dexterity Potion
        { item = xi.item.STRENGTH_POTION,  weight = 214 }, -- Strength Potion
        { item = xi.item.VITALITY_POTION,  weight = 196 }, -- Vitality Potion
    },

    {
        { item = xi.item.CHUNK_OF_ADAMAN_ORE,     weight = 107 }, -- Chunk Of Adaman Ore
        { item = xi.item.CHARISMA_POTION,         weight =  89 }, -- Charisma Potion
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight = 179 }, -- Chunk Of Darksteel Ore
        { item = xi.item.ICARUS_WING,             weight = 134 }, -- Icarus Wing
        { item = xi.item.INTELLIGENCE_POTION,     weight = 152 }, -- Intelligence Potion
        { item = xi.item.MIND_POTION,             weight =  80 }, -- Mind Potion
        { item = xi.item.CHUNK_OF_ORICHALCUM_ORE, weight =  80 }, -- Chunk Of Orichalcum Ore
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,   weight = 107 }, -- Chunk Of Platinum Ore
        { item = xi.item.PRINCELY_SWORD,          weight = 152 }, -- Princely Sword
    },

    {
        { item = xi.item.HI_ETHER_P3,    weight = 295 },  -- Hi-ether +3
        { item = xi.item.HI_POTION_P3,   weight = 250 },  -- Hi-potion +3
        { item = xi.item.HI_RERAISER,    weight = 196 },  -- Hi-reraiser
        { item = xi.item.VILE_ELIXIR_P1, weight = 214 },  -- Vile Elixir +1
    },

    {
        { item = xi.item.CORAL_FRAGMENT,           weight = 139 }, -- Coral Fragment
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  59 }, -- Chunk Of Darksteel Ore
        { item = xi.item.DEMON_HORN,               weight =  50 }, -- Demon Horn
        { item = xi.item.EBONY_LOG,                weight = 109 }, -- Ebony Log
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight =  69 }, -- Chunk Of Gold Ore
        { item = xi.item.SLAB_OF_GRANITE,          weight =  99 }, -- Slab Of Granite
        { item = xi.item.HI_RERAISER,              weight =  79 }, -- Hi-reraiser
        { item = xi.item.MAHOGANY_LOG,             weight = 129 }, -- Mahogany Log
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight = 119 }, -- Chunk Of Mythril Ore
        { item = xi.item.PHOENIX_FEATHER,          weight =  69 }, -- Phoenix Feather
        { item = xi.item.PETRIFIED_LOG,            weight = 168 }, -- Petrified Log
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight = 129 }, -- Chunk Of Platinum Ore
        { item = xi.item.RAM_HORN,                 weight = 109 }, -- Ram Horn
        { item = xi.item.SQUARE_OF_RAXA,           weight =  79 }, -- Square Of Raxa
        { item = xi.item.VILE_ELIXIR,              weight =  69 }, -- Vile Elixir
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  79 }, -- Handful Of Wyvern Scales
        { item = xi.item.RERAISER,                 weight =  50 }, -- Reraiser
        { item = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  89 }, -- Spool Of Gold Thread
    },

    {
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight = 109 }, -- Vial Of Black Beetle Blood
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  89 }, -- Square Of Damascene Cloth
        { item = xi.item.DAMASCUS_INGOT,             weight =  79 }, -- Damascus Ingot
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  99 }, -- Spool Of Malboro Fiber
        { item = xi.item.PHILOSOPHERS_STONE,         weight = 188 }, -- Philosophers Stone
        { item = xi.item.PHOENIX_FEATHER,            weight = 238 }, -- Phoenix Feather
        { item = xi.item.SQUARE_OF_RAXA,             weight = 109 }, -- Square Of Raxa
    },

    {
        { item = xi.item.DIVINE_LOG,              weight =  79 }, -- Divine Log
        { item = xi.item.LACQUER_TREE_LOG,        weight = 257 }, -- Lacquer Tree Log
        { item = xi.item.PETRIFIED_LOG,           weight = 337 }, -- Petrified Log
        { item = xi.item.SQUARE_OF_SHINING_CLOTH, weight = 149 }, -- Square Of Shining Cloth
    },
}

return content:register()
