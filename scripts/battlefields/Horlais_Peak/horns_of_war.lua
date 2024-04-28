-----------------------------------
-- Horns of War
-- Horlais Peak KSNM, Themis Orb
-- !additem 1553
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.HORNS_OF_WAR,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 11,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.THEMIS_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'Chlevnik' })

content.loot =
{
    {
        { item = xi.item.LIBATION_ABJURATION, weight = 169 }, -- Libation Abjuration
        { item = xi.item.KRIEGSBEIL,          weight = 268 }, -- Kriegsbeil
        { item = xi.item.SHINSOKU,            weight =  99 }, -- Shinsoku
        { item = xi.item.NOKIZARU_SHURIKEN,   weight =  85 }, -- Nokizaru Shuriken
        { item = xi.item.GUESPIERE,           weight =  70 }, -- Guespiere
        { item = xi.item.PURGATORY_MACE,      weight =  85 }, -- Purgatory Mace
        { item = xi.item.METEOR_CESTI,        weight = 225 }, -- Meteor Cesti
    },

    {
        { item = xi.item.OBLATION_ABJURATION, weight = 169 }, -- Oblation Abjuration
        { item = xi.item.UNSHO,               weight =  14 }, -- Unsho
        { item = xi.item.HARLEQUINS_HORN,     weight = 239 }, -- Harlequins Horn
        { item = xi.item.DREIZACK,            weight =  85 }, -- Dreizack
        { item = xi.item.GAWAINS_AXE,         weight = 254 }, -- Gawains Axe
        { item = xi.item.ZEN_POLE,            weight = 183 }, -- Zen Pole
        { item = xi.item.BAYARDS_SWORD,       weight  = 70 }, -- Bayards Sword
    },

    {
        { item = xi.item.PETRIFIED_LOG,           weight = 563 }, -- Petrified Log
        { item = xi.item.LACQUER_TREE_LOG,        weight = 296 }, -- Lacquer Tree Log
        { item = xi.item.SQUARE_OF_SHINING_CLOTH, weight =  14 }, -- Square Of Shining Cloth
        { item = xi.item.DIVINE_LOG,              weight = 141 }, -- Divine Log
    },

    {
        { item = xi.item.BEHEMOTH_HIDE, weight = 535 }, -- Behemoth Hide
        { item = xi.item.BEHEMOTH_HORN, weight = 366 }, -- Behemoth Horn
        { item = xi.item.HEALING_STAFF, weight =  48 }, -- Healing Staff
    },

    {
        { item = xi.item.DEMON_HORN,               weight =  99 }, -- Demon Horn
        { item = xi.item.PETRIFIED_LOG,            weight =  70 }, -- Petrified Log
        { item = xi.item.SQUARE_OF_RAXA,           weight =  70 }, -- Square Of Raxa
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  28 }, -- Square Of Rainbow Cloth
        { item = xi.item.HI_RERAISER,              weight = 113 }, -- Hi-reraiser
        { item = xi.item.PETRIFIED_LOG,            weight = 211 }, -- Petrified Log
        { item = xi.item.PHILOSOPHERS_STONE,       weight = 141 }, -- Philosophers Stone
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight =  56 }, -- Chunk Of Gold Ore
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  85 }, -- Chunk Of Mythril Ore
        { item = xi.item.CORAL_FRAGMENT,           weight =  70 }, -- Coral Fragment
        { item = xi.item.MAHOGANY_LOG,             weight =  85 }, -- Mahogany Log
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  42 }, -- Handful Of Wyvern Scales
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  42 }, -- Chunk Of Darksteel Ore
        { item = xi.item.RAM_HORN,                 weight =  70 }, -- Ram Horn
        { item = xi.item.EBONY_LOG,                weight =  85 }, -- Ebony Log
        { item = xi.item.RERAISER,                 weight =  28 }, -- Reraiser
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  42 }, -- Chunk Of Platinum Ore
        { item = xi.item.VILE_ELIXIR,              weight =  42 }, -- Vile Elixir
        { item = xi.item.VILE_ELIXIR_P1,           weight =   7 }, -- Vile Elixir +1
    },

    {
        { item = xi.item.BEHEMOTH_TONGUE,  weight = 208 }, -- Behemoth Tongue
        { item = xi.item.BEHEMOTH_HORN,    weight = 296 }, -- Behemoth Horn
        { item = xi.item.STRENGTH_POTION,  weight = 155 }, -- Strength Potion
        { item = xi.item.DEXTERITY_POTION, weight =  70 }, -- Dexterity Potion
        { item = xi.item.AGILITY_POTION,   weight = 141 }, -- Agility Potion
        { item = xi.item.VITALITY_POTION,  weight = 113 }, -- Vitality Potion
    },

    {
        { item = xi.item.BEASTLY_SHANK, weight = 1000 }, -- Beastly Shank
    },

    {
        { item = xi.item.MIND_POTION,         weight = 169 }, -- Mind Potion
        { item = xi.item.INTELLIGENCE_POTION, weight =  70 }, -- Intelligence Potion
        { item = xi.item.CHARISMA_POTION,     weight = 113 }, -- Charisma Potion
        { item = xi.item.ICARUS_WING,         weight = 155 }, -- Icarus Wing
        { item = xi.item.ANGEL_LYRE,          weight = 254 }, -- Angel Lyre
        { item = xi.item.EMERALD,             weight =  99 }, -- Emerald
        { item = xi.item.SPINEL,              weight =  42 }, -- Spinel
        { item = xi.item.RUBY,                weight =  56 }, -- Ruby
        { item = xi.item.DIAMOND,             weight =  28 }, -- Diamond
    },

    {
        { item = xi.item.HI_ETHER_P3,    weight = 296 }, -- Hi-ether +3
        { item = xi.item.HI_POTION_P3,   weight = 225 }, -- Hi-potion +3
        { item = xi.item.HI_RERAISER,    weight = 197 }, -- Hi-reraiser
        { item = xi.item.VILE_ELIXIR_P1, weight = 282 }, -- Vile Elixir +1
    },

    {
        { item = xi.item.CORAL_FRAGMENT,           weight = 141 }, -- Coral Fragment
        { item = xi.item.SQUARE_OF_RAXA,           weight =  14 }, -- Square Of Raxa
        { item = xi.item.DEMON_HORN,               weight = 113 }, -- Demon Horn
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight =  28 }, -- Chunk Of Gold Ore
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  85 }, -- Chunk Of Mythril Ore
        { item = xi.item.VILE_ELIXIR,              weight =  56 }, -- Vile Elixir
        { item = xi.item.RAM_HORN,                 weight =  28 }, -- Ram Horn
        { item = xi.item.PETRIFIED_LOG,            weight = 296 }, -- Petrified Log
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  14 }, -- Chunk Of Platinum Ore
        { item = xi.item.MAHOGANY_LOG,             weight =  56 }, -- Mahogany Log
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  70 }, -- Handful Of Wyvern Scales
        { item = xi.item.SLAB_OF_GRANITE,          weight =  42 }, -- Slab Of Granite
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  42 }, -- Chunk Of Darksteel Ore
        { item = xi.item.EBONY_LOG,                weight =  42 }, -- Ebony Log
        { item = xi.item.HI_RERAISER,              weight =  42 }, -- Hi-reraiser
        { item = xi.item.SPOOL_OF_GOLD_THREAD,     weight = 113 }, -- Spool Of Gold Thread
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  28 }, -- Square Of Rainbow Cloth
    },

    {
        { item = xi.item.SQUARE_OF_RAXA,             weight = 127 }, -- Square Of Raxa
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  56 }, -- Spool Of Malboro Fiber
        { item = xi.item.PHILOSOPHERS_STONE,         weight = 225 }, -- Philosophers Stone
        { item = xi.item.PHOENIX_FEATHER,            weight = 423 }, -- Phoenix Feather
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  70 }, -- Square Of Damascene Cloth
        { item = xi.item.DAMASCUS_INGOT,             weight =  42 }, -- Damascus Ingot
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  85 }, -- Vial Of Black Beetle Blood
    },
}

return content:register()
