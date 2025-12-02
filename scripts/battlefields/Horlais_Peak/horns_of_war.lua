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
})

content:addEssentialMobs({ 'Chlevnik' })

content.loot =
{
    {
        { itemId = xi.item.GIL, weight = 1000, amount = 32000 }, -- Gil
    },

    {
        { itemId = xi.item.LIBATION_ABJURATION, weight = 169 }, -- Libation Abjuration
        { itemId = xi.item.KRIEGSBEIL,          weight = 268 }, -- Kriegsbeil
        { itemId = xi.item.SHINSOKU,            weight =  99 }, -- Shinsoku
        { itemId = xi.item.NOKIZARU_SHURIKEN,   weight =  85 }, -- Nokizaru Shuriken
        { itemId = xi.item.GUESPIERE,           weight =  70 }, -- Guespiere
        { itemId = xi.item.PURGATORY_MACE,      weight =  85 }, -- Purgatory Mace
        { itemId = xi.item.METEOR_CESTI,        weight = 225 }, -- Meteor Cesti
    },

    {
        { itemId = xi.item.OBLATION_ABJURATION, weight = 169 }, -- Oblation Abjuration
        { itemId = xi.item.UNSHO,               weight =  14 }, -- Unsho
        { itemId = xi.item.HARLEQUINS_HORN,     weight = 239 }, -- Harlequins Horn
        { itemId = xi.item.DREIZACK,            weight =  85 }, -- Dreizack
        { itemId = xi.item.GAWAINS_AXE,         weight = 254 }, -- Gawains Axe
        { itemId = xi.item.ZEN_POLE,            weight = 183 }, -- Zen Pole
        { itemId = xi.item.BAYARDS_SWORD,       weight  = 70 }, -- Bayards Sword
    },

    {
        { itemId = xi.item.PETRIFIED_LOG,           weight = 563 }, -- Petrified Log
        { itemId = xi.item.LACQUER_TREE_LOG,        weight = 296 }, -- Lacquer Tree Log
        { itemId = xi.item.SQUARE_OF_SHINING_CLOTH, weight =  14 }, -- Square Of Shining Cloth
        { itemId = xi.item.DIVINE_LOG,              weight = 141 }, -- Divine Log
    },

    {
        { itemId = xi.item.BEHEMOTH_HIDE, weight = 535 }, -- Behemoth Hide
        { itemId = xi.item.BEHEMOTH_HORN, weight = 366 }, -- Behemoth Horn
        { itemId = xi.item.HEALING_STAFF, weight =  48 }, -- Healing Staff
    },

    {
        { itemId = xi.item.DEMON_HORN,               weight =  99 }, -- Demon Horn
        { itemId = xi.item.PETRIFIED_LOG,            weight =  70 }, -- Petrified Log
        { itemId = xi.item.SQUARE_OF_RAXA,           weight =  70 }, -- Square Of Raxa
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  28 }, -- Square Of Rainbow Cloth
        { itemId = xi.item.HI_RERAISER,              weight = 113 }, -- Hi-reraiser
        { itemId = xi.item.PETRIFIED_LOG,            weight = 211 }, -- Petrified Log
        { itemId = xi.item.PHILOSOPHERS_STONE,       weight = 141 }, -- Philosophers Stone
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight =  56 }, -- Chunk Of Gold Ore
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  85 }, -- Chunk Of Mythril Ore
        { itemId = xi.item.CORAL_FRAGMENT,           weight =  70 }, -- Coral Fragment
        { itemId = xi.item.MAHOGANY_LOG,             weight =  85 }, -- Mahogany Log
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  42 }, -- Handful Of Wyvern Scales
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  42 }, -- Chunk Of Darksteel Ore
        { itemId = xi.item.RAM_HORN,                 weight =  70 }, -- Ram Horn
        { itemId = xi.item.EBONY_LOG,                weight =  85 }, -- Ebony Log
        { itemId = xi.item.RERAISER,                 weight =  28 }, -- Reraiser
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  42 }, -- Chunk Of Platinum Ore
        { itemId = xi.item.VILE_ELIXIR,              weight =  42 }, -- Vile Elixir
        { itemId = xi.item.VILE_ELIXIR_P1,           weight =   7 }, -- Vile Elixir +1
    },

    {
        { itemId = xi.item.BEHEMOTH_TONGUE,  weight = 208 }, -- Behemoth Tongue
        { itemId = xi.item.BEHEMOTH_HORN,    weight = 296 }, -- Behemoth Horn
        { itemId = xi.item.STRENGTH_POTION,  weight = 155 }, -- Strength Potion
        { itemId = xi.item.DEXTERITY_POTION, weight =  70 }, -- Dexterity Potion
        { itemId = xi.item.AGILITY_POTION,   weight = 141 }, -- Agility Potion
        { itemId = xi.item.VITALITY_POTION,  weight = 113 }, -- Vitality Potion
    },

    {
        { itemId = xi.item.BEASTLY_SHANK, weight = 1000 }, -- Beastly Shank
    },

    {
        { itemId = xi.item.MIND_POTION,         weight = 169 }, -- Mind Potion
        { itemId = xi.item.INTELLIGENCE_POTION, weight =  70 }, -- Intelligence Potion
        { itemId = xi.item.CHARISMA_POTION,     weight = 113 }, -- Charisma Potion
        { itemId = xi.item.ICARUS_WING,         weight = 155 }, -- Icarus Wing
        { itemId = xi.item.ANGEL_LYRE,          weight = 254 }, -- Angel Lyre
        { itemId = xi.item.EMERALD,             weight =  99 }, -- Emerald
        { itemId = xi.item.SPINEL,              weight =  42 }, -- Spinel
        { itemId = xi.item.RUBY,                weight =  56 }, -- Ruby
        { itemId = xi.item.DIAMOND,             weight =  28 }, -- Diamond
    },

    {
        { itemId = xi.item.HI_ETHER_P3,    weight = 296 }, -- Hi-ether +3
        { itemId = xi.item.HI_POTION_P3,   weight = 225 }, -- Hi-potion +3
        { itemId = xi.item.HI_RERAISER,    weight = 197 }, -- Hi-reraiser
        { itemId = xi.item.VILE_ELIXIR_P1, weight = 282 }, -- Vile Elixir +1
    },

    {
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 127 }, -- Square Of Raxa
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  56 }, -- Spool Of Malboro Fiber
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight = 225 }, -- Philosophers Stone
        { itemId = xi.item.PHOENIX_FEATHER,            weight = 423 }, -- Phoenix Feather
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  70 }, -- Square Of Damascene Cloth
        { itemId = xi.item.DAMASCUS_INGOT,             weight =  42 }, -- Damascus Ingot
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  85 }, -- Vial Of Black Beetle Blood
    },
}

return content:register()
