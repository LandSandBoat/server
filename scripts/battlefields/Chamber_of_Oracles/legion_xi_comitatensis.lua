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
    armouryCrates    =
    {
        chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 4,
        chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 9,
        chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 14,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII,
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 1,
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 2,
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 3,
            },

            {
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 5,
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 6,
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 7,
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 8,
            },

            {
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 10,
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 11,
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 12,
                chamberOfOraclesID.mob.SECUTOR_XI_XXXII + 13,
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL, weight = 1000, amount = 18000 },
    },

    {
        { itemId = xi.item.NONE,             weight = 100 }, -- nothing
        { itemId = xi.item.EVASION_TORQUE,   weight = 150 }, -- evasion_torque
        { itemId = xi.item.PARRYING_TORQUE,  weight = 150 }, -- parrying_torque
        { itemId = xi.item.GUARDING_TORQUE,  weight = 150 }, -- guarding_torque
        { itemId = xi.item.NINJUTSU_TORQUE,  weight = 150 }, -- ninjutsu_torque
        { itemId = xi.item.WIND_TORQUE,      weight = 150 }, -- wind_torque
        { itemId = xi.item.SUMMONING_TORQUE, weight = 150 }, -- summoning_torque
    },

    {
        { itemId = xi.item.NONE,              weight = 100 }, -- nothing
        { itemId = xi.item.DIVINE_TORQUE,     weight = 150 }, -- divine_torque
        { itemId = xi.item.DARK_TORQUE,       weight = 150 }, -- dark_torque
        { itemId = xi.item.ENHANCING_TORQUE,  weight = 150 }, -- enhancing_torque
        { itemId = xi.item.ENFEEBLING_TORQUE, weight = 150 }, -- enfeebling_torque
        { itemId = xi.item.ELEMENTAL_TORQUE,  weight = 150 }, -- elemental_torque
        { itemId = xi.item.HEALING_TORQUE,    weight = 150 }, -- healing_torque
    },

    {
        { itemId = xi.item.SUNSTONE,          weight = 100 }, -- sunstone
        { itemId = xi.item.CHUNK_OF_GOLD_ORE, weight = 100 }, -- chunk_of_gold_ore
        { itemId = xi.item.JADEITE,           weight = 100 }, -- jadeite
        { itemId = xi.item.FLUORITE,          weight = 100 }, -- fluorite
        { itemId = xi.item.DARKSTEEL_INGOT,   weight = 100 }, -- darksteel_ingot
        { itemId = xi.item.ZIRCON,            weight = 100 }, -- zircon
        { itemId = xi.item.CHRYSOBERYL,       weight = 100 }, -- chrysoberyl
        { itemId = xi.item.MOONSTONE,         weight = 100 }, -- moonstone
        { itemId = xi.item.PAINITE,           weight = 100 }, -- painite
        { itemId = xi.item.STEEL_INGOT,       weight = 100 }, -- steel_ingot
    },

    {
        { itemId = xi.item.NONE,               weight = 500 }, -- nothing
        { itemId = xi.item.SCROLL_OF_RAISE_II, weight = 500 }, -- scroll_of_raise_ii
    },

    {
        { itemId = xi.item.NONE,           weight = 950 }, -- nothing
        { itemId = xi.item.VILE_ELIXIR_P1, weight =  50 }, -- vile_elixir_+1
    },

    {
        { itemId = xi.item.YELLOW_ROCK,        weight =  50 }, -- yellow_rock
        { itemId = xi.item.WHITE_ROCK,         weight =  50 }, -- white_rock
        { itemId = xi.item.EBONY_LOG,          weight = 125 }, -- ebony_log
        { itemId = xi.item.PLATINUM_BEASTCOIN, weight = 775 }, -- platinum_beastcoin
    },

    {
        { itemId = xi.item.NONE,                   weight = 600 }, -- nothing
        { itemId = xi.item.CHUNK_OF_WATER_ORE,     weight =  50 }, -- chunk_of_water_ore
        { itemId = xi.item.CHUNK_OF_ICE_ORE,       weight =  50 }, -- chunk_of_ice_ore
        { itemId = xi.item.CHUNK_OF_LIGHTNING_ORE, weight =  50 }, -- chunk_of_lightning_ore
        { itemId = xi.item.CHUNK_OF_EARTH_ORE,     weight =  50 }, -- chunk_of_earth_ore
        { itemId = xi.item.CHUNK_OF_FIRE_ORE,      weight =  50 }, -- chunk_of_fire_ore
        { itemId = xi.item.CHUNK_OF_LIGHT_ORE,     weight =  50 }, -- chunk_of_light_ore
        { itemId = xi.item.CHUNK_OF_DARK_ORE,      weight =  50 }, -- chunk_of_dark_ore
        { itemId = xi.item.CHUNK_OF_WIND_ORE,      weight =  50 }, -- chunk_of_wind_ore
    },
}

return content:register()
