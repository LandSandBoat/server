-----------------------------------
-- Amphibian Assault
-- Sacrificial Chamber BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local sacrificialChamberID = zones[xi.zone.SACRIFICIAL_CHAMBER]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.SACRIFICIAL_CHAMBER,
    battlefieldId    = xi.battlefield.id.AMPHIBIAN_ASSAULT,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = '_4j0',
    exitNpcs         = { '_4j2', '_4j3', '_4j4' },
    requiredItems    = { xi.item.MOON_ORB, wearMessage = sacrificialChamberID.text.A_CRACK_HAS_FORMED, wornMessage = sacrificialChamberID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 4,
        sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 10,
        sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 16,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER,
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 1,
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 2,
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 3,
            },

            {
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 6,
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 7,
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 8,
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 9,
            },

            {
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 12,
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 13,
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 14,
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 15,
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },

    -- Wyvern
    {
        mobIds =
        {
            { sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 5  },
            { sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 11 },
            { sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 17 },
        },

        spawned = false,
    },
}

content.loot =
{
    {
        { itemId = xi.item.ENFEEBLING_TORQUE, weight = 250 }, -- Enfeebling Torque
        { itemId = xi.item.DIVINE_TORQUE,     weight = 250 }, -- Divine Torque
        { itemId = xi.item.SHIELD_TORQUE,     weight = 250 }, -- Shield Torque
        { itemId = xi.item.STRING_TORQUE,     weight = 250 }, -- String Torque
    },

    {
        { itemId = xi.item.ELEMENTAL_TORQUE, weight = 250 }, -- Elemental Torque
        { itemId = xi.item.EVASION_TORQUE,   weight = 250 }, -- Evasion Torque
        { itemId = xi.item.GUARDING_TORQUE,  weight = 250 }, -- Guarding Torque
        { itemId = xi.item.ENHANCING_TORQUE, weight = 250 }, -- Enhancing Torque
    },

    {
        { itemId = xi.item.CHUNK_OF_WATER_ORE,     weight = 125 }, -- Chunk Of Water Ore
        { itemId = xi.item.CHUNK_OF_WIND_ORE,      weight = 125 }, -- Chunk Of Wind Ore
        { itemId = xi.item.CHUNK_OF_ICE_ORE,       weight = 125 }, -- Chunk Of Ice Ore
        { itemId = xi.item.CHUNK_OF_LIGHTNING_ORE, weight = 125 }, -- Chunk Of Lightning Ore
        { itemId = xi.item.CHUNK_OF_LIGHT_ORE,     weight = 125 }, -- Chunk Of Light Ore
        { itemId = xi.item.CHUNK_OF_FIRE_ORE,      weight = 125 }, -- Chunk Of Fire Ore
        { itemId = xi.item.CHUNK_OF_DARK_ORE,      weight = 125 }, -- Chunk Of Dark Ore
        { itemId = xi.item.CHUNK_OF_EARTH_ORE,     weight = 125 }, -- Chunk Of Earth Ore
    },

    {
        { itemId = xi.item.NONE,             weight = 750 }, -- nothing
        { itemId = xi.item.SUMMONING_TORQUE, weight = 250 }, -- Summoning Torque
    },

    {
        { itemId = xi.item.NONE,               weight = 200 }, -- nothing
        { itemId = xi.item.PLATINUM_BEASTCOIN, weight = 800 }, -- Platinum Beastcoin
    },

    {
        { itemId = xi.item.NONE,                 weight = 375 }, -- nothing
        { itemId = xi.item.FIRE_SPIRIT_PACT,     weight = 125 }, -- Fire Spirit Pact
        { itemId = xi.item.SCROLL_OF_ABSORB_STR, weight = 125 }, -- Scroll Of Absorb-str
        { itemId = xi.item.SCROLL_OF_ERASE,      weight = 125 }, -- Scroll Of Erase
        { itemId = xi.item.SCROLL_OF_PHALANX,    weight = 125 }, -- Scroll Of Phalanx
        { itemId = xi.item.SCROLL_OF_RAISE_II,   weight = 125 }, -- Scroll Of Raise Ii
    },

    {
        { itemId = xi.item.NONE,           weight = 888 }, -- nothing
        { itemId = xi.item.VILE_ELIXIR_P1, weight =  56 }, -- Vile Elixir +1
        { itemId = xi.item.HI_RERAISER,    weight =  56 }, -- Hi-reraiser
    },

    {
        { itemId = xi.item.FLUORITE,         weight =  10 }, -- Fluorite
        { itemId = xi.item.PAINITE,          weight =  50 }, -- Painite
        { itemId = xi.item.SUNSTONE,         weight =  10 }, -- Sunstone
        { itemId = xi.item.JADEITE,          weight = 150 }, -- Jadeite
        { itemId = xi.item.AQUAMARINE,       weight =  50 }, -- Aquamarine
        { itemId = xi.item.MOONSTONE,        weight = 150 }, -- Moonstone
        { itemId = xi.item.YELLOW_ROCK,      weight =  50 }, -- Yellow Rock
        { itemId = xi.item.RED_ROCK,         weight =  50 }, -- Red Rock
        { itemId = xi.item.WHITE_ROCK,       weight = 100 }, -- White Rock
        { itemId = xi.item.GREEN_ROCK,       weight =  50 }, -- Green Rock
        { itemId = xi.item.TRANSLUCENT_ROCK, weight = 100 }, -- Translucent Rock
        { itemId = xi.item.CHRYSOBERYL,      weight = 150 }, -- Chrysoberyl
        { itemId = xi.item.BLACK_ROCK,       weight =  50 }, -- Black Rock
        { itemId = xi.item.PURPLE_ROCK,      weight =  50 }, -- Purple Rock
    },

    {
        { itemId = xi.item.PLATINUM_BEASTCOIN,     weight = 500 }, -- Platinum Beastcoin
        { itemId = xi.item.CORAL_FRAGMENT,         weight = 222 }, -- Coral Fragment
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER, weight =  10 }, -- Spool Of Malboro Fiber
        { itemId = xi.item.STEEL_INGOT,            weight = 111 }, -- Steel Ingot
        { itemId = xi.item.EBONY_LOG,              weight =  56 }, -- Ebony Log
    },
}

return content:register()
