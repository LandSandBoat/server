-----------------------------------
-- The Scarlet King
-- Chamber of Oracles KSNM30, Atropos Orb
-- !additem 1180
-----------------------------------
local chamberOfOraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.CHAMBER_OF_ORACLES,
    battlefieldId    = xi.battlefield.id.SCARLET_KING,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 7, -- "The Scarlet King"
    entryNpc         = 'SC_Entrance',
    exitNpc          = 'Shimmering_Circle',
    requiredItems    = { xi.item.ATROPOS_ORB, wearMessage = chamberOfOraclesID.text.A_CRACK_HAS_FORMED, wornMessage = chamberOfOraclesID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Purson' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                        weight = 10000, amount = 24000 },
    },

    {
        { itemId = xi.item.MANTICORE_HIDE,             weight = 10000 },
    },

    {
        { itemId = xi.item.LOCK_OF_MANTICORE_HAIR,     weight = 10000 },
    },

    {
        { itemId = xi.item.BALANS_SWORD,               weight =  1875 },
        { itemId = xi.item.KING_MAKER,                 weight =  1875 },
        { itemId = xi.item.CAPRICORN_STAFF,            weight =  1875 },
        { itemId = xi.item.ARGENT_DAGGER,              weight =  1875 },
        { itemId = xi.item.DAMASCUS_INGOT,             weight =   625 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =   625 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =   625 },
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =   625 },
    },

    {
        { itemId = xi.item.HONEBAMI,                   weight =  2500 },
        { itemId = xi.item.SPEAR_STRAP,                weight =  1500 },
        { itemId = xi.item.SWORD_STRAP,                weight =  1500 },
        { itemId = xi.item.CLAYMORE_GRIP,              weight =  2000 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight =  1250 },
        { itemId = xi.item.VILE_ELIXIR,                weight =  1250 },
    },

    {
        { itemId = xi.item.NONE,                       weight =  1500 },
        { itemId = xi.item.THANATOS_BASELARD,          weight =  1500 },
        { itemId = xi.item.BALINS_SWORD,               weight =  1500 },
        { itemId = xi.item.WYVERN_PERCH,               weight =  1500 },
        { itemId = xi.item.WOODVILLES_AXE,             weight =  1500 },
        { itemId = xi.item.LIGHT_SPIRIT_PACT,          weight =   500 },
        { itemId = xi.item.SCROLL_OF_CURE_V,           weight =   500 },
        { itemId = xi.item.SCROLL_OF_RAISE_III,        weight =   500 },
        { itemId = xi.item.SCROLL_OF_SHELL_IV,         weight =   500 },
        { itemId = xi.item.SCROLL_OF_THUNDER_III,      weight =   500 },
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =   550 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =   560 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =   560 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =   550 },
        { itemId = xi.item.EBONY_LOG,                  weight =   560 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =   560 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =   550 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =   550 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =   560 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =   560 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =   550 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =   550 },
        { itemId = xi.item.DEMON_HORN,                 weight =   550 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =   550 },
        { itemId = xi.item.RAM_HORN,                   weight =   560 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =   560 },
        { itemId = xi.item.RERAISER,                   weight =   560 },
        { itemId = xi.item.HI_RERAISER,                weight =   560 },
    },

    {
        { itemId = xi.item.NONE,                       weight =  3600 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =   400 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =   400 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =   400 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =   400 },
        { itemId = xi.item.EBONY_LOG,                  weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =   400 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =   400 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =   400 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =   400 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =   400 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =   400 },
        { itemId = xi.item.DEMON_HORN,                 weight =   400 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =   400 },
        { itemId = xi.item.RAM_HORN,                   weight =   400 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =   400 },
    },

    {
        { itemId = xi.item.NONE,                       weight =  3000 },
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =   435 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =   435 },
        { itemId = xi.item.DAMASCUS_INGOT,             weight =   435 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =   435 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =  1400 },
        { itemId = xi.item.PHOENIX_FEATHER,            weight =  2450 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =  1400 },
    },
}
return content:register()
