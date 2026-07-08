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
        { itemId = xi.item.GIL,                        weight = 10000, amount = 32000 },
    },

    {
        { itemId = xi.item.CLUMP_OF_BLUE_PONDWEED,     weight = 10000 },
    },

    {
        { itemId = xi.item.LIBATION_ABJURATION,        weight =  2500 },
        { itemId = xi.item.HAVOC_SCYTHE,               weight =  1250 },
        { itemId = xi.item.KRIEGSBEIL,                 weight =  1250 },
        { itemId = xi.item.LEOPARD_AXE,                weight =  1250 },
        { itemId = xi.item.METEOR_CESTI,               weight =  1250 },
        { itemId = xi.item.PURGATORY_MACE,             weight =  1250 },
        { itemId = xi.item.SOMNUS_SIGNA,               weight =  1250 },
    },

    {
        { itemId = xi.item.OBLATION_ABJURATION,        weight =  2500 },
        { itemId = xi.item.GAWAINS_AXE,                weight =  1250 },
        { itemId = xi.item.GRIM_STAFF,                 weight =  1250 },
        { itemId = xi.item.GROSVENEURS_BOW,            weight =  1250 },
        { itemId = xi.item.HARLEQUINS_HORN,            weight =  1250 },
        { itemId = xi.item.STYLET,                     weight =  1250 },
        { itemId = xi.item.ZEN_POLE,                   weight =  1250 },
    },

    {
        { itemId = xi.item.ADAMAN_CHAIN,               weight =  4500 },
        { itemId = xi.item.ADAMANTOISE_SHELL,          weight =  4250 },
        { itemId = xi.item.PIECE_OF_ANGEL_SKIN,        weight =   750 },
        { itemId = xi.item.STRIDER_BOOTS,              weight =   500 },
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =   500 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =   500 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =   500 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =   500 },
        { itemId = xi.item.EBONY_LOG,                  weight =   500 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =   500 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =   500 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =   500 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =   500 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =   500 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =   500 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =   500 },
        { itemId = xi.item.DEMON_HORN,                 weight =   500 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =   500 },
        { itemId = xi.item.RAM_HORN,                   weight =   500 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =   500 },
        { itemId = xi.item.RERAISER,                   weight =   500 },
        { itemId = xi.item.HI_RERAISER,                weight =   500 },
        { itemId = xi.item.VILE_ELIXIR,                weight =   500 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight =   500 },
    },

    {
        { itemId = xi.item.ADAMANTOISE_EGG,            weight =  2500 },
        { itemId = xi.item.ADAMAN_CHAIN,               weight =  3000 },
        { itemId = xi.item.AGILITY_POTION,             weight =  1125 },
        { itemId = xi.item.DEXTERITY_POTION,           weight =  1125 },
        { itemId = xi.item.STRENGTH_POTION,            weight =  1125 },
        { itemId = xi.item.VITALITY_POTION,            weight =  1125 },
    },

    {
        { itemId = xi.item.MIND_POTION,                weight =  1250 },
        { itemId = xi.item.INTELLIGENCE_POTION,        weight =  1250 },
        { itemId = xi.item.CHARISMA_POTION,            weight =  1250 },
        { itemId = xi.item.ICARUS_WING,                weight =  1250 },
        { itemId = xi.item.CHUNK_OF_ADAMAN_ORE,        weight =   625 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =   625 },
        { itemId = xi.item.CHUNK_OF_ORICHALCUM_ORE,    weight =   625 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =   625 },
        { itemId = xi.item.PRINCELY_SWORD,             weight =  2500 },
    },

    {
        { itemId = xi.item.HI_ETHER_P3,                weight =  2500 },
        { itemId = xi.item.HI_POTION_P3,               weight =  2500 },
        { itemId = xi.item.HI_RERAISER,                weight =  2500 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight =  2500 },
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =   625 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =   625 },
        { itemId = xi.item.DAMASCUS_INGOT,             weight =   625 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =   625 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =  2000 },
        { itemId = xi.item.PHOENIX_FEATHER,            weight =  3500 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =  2000 },
    },

    {
        { itemId = xi.item.DIVINE_LOG,                 weight =  1000 },
        { itemId = xi.item.LACQUER_TREE_LOG,           weight =  2500 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =  6000 },
        { itemId = xi.item.SQUARE_OF_SHINING_CLOTH,    weight =   500 },
    },
}

return content:register()
