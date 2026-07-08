-----------------------------------
-- Legion XI Comitatensis
-- Chamber of Oracles BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local chamberOfOraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.CHAMBER_OF_ORACLES,
    battlefieldId    = xi.battlefield.id.LEGION_XI_COMITATENSIS,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'SC_Entrance',
    exitNpc          = 'Shimmering_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = chamberOfOraclesID.text.A_CRACK_HAS_FORMED, wornMessage = chamberOfOraclesID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Secutor_XI-XXXII', 'Retiarius_XI-XIX', 'Hoplomachus_XI-XXVI', 'Centurio_XI-I' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                    weight = 10000, amount = 18000 },
    },

    {
        { itemId = xi.item.EVASION_TORQUE,         weight =  2500 },
        { itemId = xi.item.NINJUTSU_TORQUE,        weight =  2500 },
        { itemId = xi.item.PARRYING_TORQUE,        weight =  2500 },
        { itemId = xi.item.SUMMONING_TORQUE,       weight =  2500 },
    },

    {
        { itemId = xi.item.PLATINUM_BEASTCOIN,     weight =  5000 },
        { itemId = xi.item.FIRE_SPIRIT_PACT,       weight =  1000 },
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,   weight =  1000 },
        { itemId = xi.item.SCROLL_OF_ERASE,        weight =  1000 },
        { itemId = xi.item.SCROLL_OF_PHALANX,      weight =  1000 },
        { itemId = xi.item.SCROLL_OF_RAISE_II,     weight =  1000 },
    },

    {
        { itemId = xi.item.PLATINUM_BEASTCOIN,     weight =  5000 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,      weight =   500 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =   500 },
        { itemId = xi.item.CHUNK_OF_DARK_ORE,      weight =   500 },
        { itemId = xi.item.CHUNK_OF_EARTH_ORE,     weight =   500 },
        { itemId = xi.item.CHUNK_OF_FIRE_ORE,      weight =   500 },
        { itemId = xi.item.CHUNK_OF_ICE_ORE,       weight =   500 },
        { itemId = xi.item.CHUNK_OF_LIGHTNING_ORE, weight =   500 },
        { itemId = xi.item.CHUNK_OF_LIGHT_ORE,     weight =   500 },
        { itemId = xi.item.CHUNK_OF_WATER_ORE,     weight =   500 },
        { itemId = xi.item.CHUNK_OF_WIND_ORE,      weight =   500 },
    },

    {
        { itemId = xi.item.DIVINE_TORQUE,          weight =  2500 },
        { itemId = xi.item.ELEMENTAL_TORQUE,       weight =  2500 },
        { itemId = xi.item.ENHANCING_TORQUE,       weight =  2500 },
        { itemId = xi.item.GUARDING_TORQUE,        weight =  2500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.AQUAMARINE,             weight =   400 },
        { itemId = xi.item.CHRYSOBERYL,            weight =   400 },
        { itemId = xi.item.FLUORITE,               weight =   400 },
        { itemId = xi.item.JADEITE,                weight =   400 },
        { itemId = xi.item.MOONSTONE,              weight =   400 },
        { itemId = xi.item.PAINITE,                weight =   400 },
        { itemId = xi.item.SUNSTONE,               weight =   400 },
        { itemId = xi.item.ZIRCON,                 weight =   400 },
        { itemId = xi.item.BLACK_ROCK,             weight =   400 },
        { itemId = xi.item.BLUE_ROCK,              weight =   400 },
        { itemId = xi.item.GREEN_ROCK,             weight =   400 },
        { itemId = xi.item.PURPLE_ROCK,            weight =   400 },
        { itemId = xi.item.RED_ROCK,               weight =   400 },
        { itemId = xi.item.TRANSLUCENT_ROCK,       weight =   400 },
        { itemId = xi.item.WHITE_ROCK,             weight =   400 },
        { itemId = xi.item.YELLOW_ROCK,            weight =   400 },
        { itemId = xi.item.EBONY_LOG,              weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,           weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,        weight =   400 },
        { itemId = xi.item.GOLD_INGOT,             weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,          weight =   400 },
        { itemId = xi.item.STEEL_INGOT,            weight =   400 },
        { itemId = xi.item.DEMON_HORN,             weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,         weight =   400 },
        { itemId = xi.item.HI_RERAISER,            weight =   200 },
        { itemId = xi.item.VILE_ELIXIR_P1,         weight =   200 },
    },
}

return content:register()
