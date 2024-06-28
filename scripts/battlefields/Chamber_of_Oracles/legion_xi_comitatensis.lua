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
        { item = xi.item.NONE,             weight = 100 }, -- nothing
        { item = xi.item.EVASION_TORQUE,   weight = 150 }, -- evasion_torque
        { item = xi.item.PARRYING_TORQUE,  weight = 150 }, -- parrying_torque
        { item = xi.item.GUARDING_TORQUE,  weight = 150 }, -- guarding_torque
        { item = xi.item.NINJUTSU_TORQUE,  weight = 150 }, -- ninjutsu_torque
        { item = xi.item.WIND_TORQUE,      weight = 150 }, -- wind_torque
        { item = xi.item.SUMMONING_TORQUE, weight = 150 }, -- summoning_torque
    },

    {
        { item = xi.item.NONE,              weight = 100 }, -- nothing
        { item = xi.item.DIVINE_TORQUE,     weight = 150 }, -- divine_torque
        { item = xi.item.DARK_TORQUE,       weight = 150 }, -- dark_torque
        { item = xi.item.ENHANCING_TORQUE,  weight = 150 }, -- enhancing_torque
        { item = xi.item.ENFEEBLING_TORQUE, weight = 150 }, -- enfeebling_torque
        { item = xi.item.ELEMENTAL_TORQUE,  weight = 150 }, -- elemental_torque
        { item = xi.item.HEALING_TORQUE,    weight = 150 }, -- healing_torque
    },

    {
        { item = xi.item.SUNSTONE,          weight = 100 }, -- sunstone
        { item = xi.item.CHUNK_OF_GOLD_ORE, weight = 100 }, -- chunk_of_gold_ore
        { item = xi.item.JADEITE,           weight = 100 }, -- jadeite
        { item = xi.item.FLUORITE,          weight = 100 }, -- fluorite
        { item = xi.item.DARKSTEEL_INGOT,   weight = 100 }, -- darksteel_ingot
        { item = xi.item.ZIRCON,            weight = 100 }, -- zircon
        { item = xi.item.CHRYSOBERYL,       weight = 100 }, -- chrysoberyl
        { item = xi.item.MOONSTONE,         weight = 100 }, -- moonstone
        { item = xi.item.PAINITE,           weight = 100 }, -- painite
        { item = xi.item.STEEL_INGOT,       weight = 100 }, -- steel_ingot
    },

    {
        { item = xi.item.NONE,               weight = 500 }, -- nothing
        { item = xi.item.SCROLL_OF_RAISE_II, weight = 500 }, -- scroll_of_raise_ii
    },

    {
        { item = xi.item.NONE,           weight = 950 }, -- nothing
        { item = xi.item.VILE_ELIXIR_P1, weight =  50 }, -- vile_elixir_+1
    },

    {
        { item = xi.item.YELLOW_ROCK,        weight =  50 }, -- yellow_rock
        { item = xi.item.WHITE_ROCK,         weight =  50 }, -- white_rock
        { item = xi.item.EBONY_LOG,          weight = 125 }, -- ebony_log
        { item = xi.item.PLATINUM_BEASTCOIN, weight = 775 }, -- platinum_beastcoin
    },

    {
        { item = xi.item.NONE,                   weight = 600 }, -- nothing
        { item = xi.item.CHUNK_OF_WATER_ORE,     weight =  50 }, -- chunk_of_water_ore
        { item = xi.item.CHUNK_OF_ICE_ORE,       weight =  50 }, -- chunk_of_ice_ore
        { item = xi.item.CHUNK_OF_LIGHTNING_ORE, weight =  50 }, -- chunk_of_lightning_ore
        { item = xi.item.CHUNK_OF_EARTH_ORE,     weight =  50 }, -- chunk_of_earth_ore
        { item = xi.item.CHUNK_OF_FIRE_ORE,      weight =  50 }, -- chunk_of_fire_ore
        { item = xi.item.CHUNK_OF_LIGHT_ORE,     weight =  50 }, -- chunk_of_light_ore
        { item = xi.item.CHUNK_OF_DARK_ORE,      weight =  50 }, -- chunk_of_dark_ore
        { item = xi.item.CHUNK_OF_WIND_ORE,      weight =  50 }, -- chunk_of_wind_ore
    },
}

return content:register()
