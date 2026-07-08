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
})

content:addEssentialMobs({ 'Wyrm' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                        weight = 10000, amount = 32000 },
    },

    {
        { itemId = xi.item.JUG_OF_HONEY_WINE,          weight = 10000 },
    },

    {
        { itemId = xi.item.LIBATION_ABJURATION,        weight = 2500 },
        { itemId = xi.item.GUESPIERE,                  weight = 1250 },
        { itemId = xi.item.HAVOC_SCYTHE,               weight = 1250 },
        { itemId = xi.item.LEOPARD_AXE,                weight = 1250 },
        { itemId = xi.item.NOKIZARU_SHURIKEN,          weight = 1250 },
        { itemId = xi.item.SHINSOKU,                   weight = 1250 },
        { itemId = xi.item.SOMNUS_SIGNA,               weight = 1250 },
    },

    {
        { itemId = xi.item.OBLATION_ABJURATION,        weight = 2500 },
        { itemId = xi.item.BAYARDS_SWORD,              weight = 1250 },
        { itemId = xi.item.DREIZACK,                   weight = 1250 },
        { itemId = xi.item.GRIM_STAFF,                 weight = 1250 },
        { itemId = xi.item.GROSVENEURS_BOW,            weight = 1250 },
        { itemId = xi.item.STYLET,                     weight = 1250 },
        { itemId = xi.item.UNSHO,                      weight = 1250 },
    },

    {
        { itemId = xi.item.DRAGON_HEART,               weight = 5200 },
        { itemId = xi.item.SLICE_OF_DRAGON_MEAT,       weight = 3500 },
        { itemId = xi.item.JUGGERNAUT,                 weight =  800 },
        { itemId = xi.item.SPEED_BELT,                 weight =  500 },
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =  500 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =  500 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =  500 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =  500 },
        { itemId = xi.item.EBONY_LOG,                  weight =  500 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =  500 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =  500 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =  500 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =  500 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =  500 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =  500 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =  500 },
        { itemId = xi.item.DEMON_HORN,                 weight =  500 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =  500 },
        { itemId = xi.item.RAM_HORN,                   weight =  500 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =  500 },
        { itemId = xi.item.RERAISER,                   weight =  500 },
        { itemId = xi.item.HI_RERAISER,                weight =  500 },
        { itemId = xi.item.VILE_ELIXIR,                weight =  500 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight =  500 },
    },

    {
        { itemId = xi.item.WYRM_BEARD,                 weight = 2500 },
        { itemId = xi.item.LOCK_OF_SIRENS_HAIR,        weight = 7500 },
    },

    {
        { itemId = xi.item.MIND_POTION,                weight = 1250 },
        { itemId = xi.item.INTELLIGENCE_POTION,        weight = 1250 },
        { itemId = xi.item.CHARISMA_POTION,            weight = 1250 },
        { itemId = xi.item.ICARUS_WING,                weight = 1250 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 2500 },
        { itemId = xi.item.PRELATIC_POLE,              weight = 2500 },
    },

    {
        { itemId = xi.item.HI_ETHER_P3,                weight = 2500 },
        { itemId = xi.item.HI_POTION_P3,               weight = 2500 },
        { itemId = xi.item.HI_RERAISER,                weight = 2500 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight = 2500 },
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  625 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  625 },
        { itemId = xi.item.DAMASCUS_INGOT,             weight =  625 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  625 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight = 2000 },
        { itemId = xi.item.PHOENIX_FEATHER,            weight = 3500 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 2000 },
    },

    {
        { itemId = xi.item.DIVINE_LOG,                 weight = 1000 },
        { itemId = xi.item.LACQUER_TREE_LOG,           weight = 2500 },
        { itemId = xi.item.PETRIFIED_LOG,              weight = 6000 },
        { itemId = xi.item.SQUARE_OF_SHINING_CLOTH,    weight =  500 },
    },
}

return content:register()
