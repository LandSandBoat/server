-----------------------------------
-- Jungle Boogymen
-- Sacrificial Chamber BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local sacrificialChamberID = zones[xi.zone.SACRIFICIAL_CHAMBER]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.SACRIFICIAL_CHAMBER,
    battlefieldId    = xi.battlefield.id.JUNGLE_BOOGYMEN,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = '_4j0',
    exitNpcs         = { '_4j2', '_4j3', '_4j4' },
    requiredItems    = { xi.item.MOON_ORB, wearMessage = sacrificialChamberID.text.A_CRACK_HAS_FORMED, wornMessage = sacrificialChamberID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 4,
        sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 11,
        sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 18,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY,
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 1,
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 2,
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 3,
            },

            {
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 7,
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 8,
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 9,
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 10,
            },

            {
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 14,
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 15,
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 16,
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 17,
            },
        },

        superlink = true,
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    -- Elemental
    {
        mobIds =
        {
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 5  },
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 12 },
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 19 },
        },
    },

    -- Avatar
    {
        mobIds =
        {
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 6  },
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 13 },
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 20 },
        },

        spawned = false,
    },
}

content.loot =
{
    {
        { item = xi.item.DARK_TORQUE,      weight = 250 }, -- Dark Torque
        { item = xi.item.ELEMENTAL_TORQUE, weight = 250 }, -- Elemental Torque
        { item = xi.item.HEALING_TORQUE,   weight = 250 }, -- Healing Torque
        { item = xi.item.WIND_TORQUE,      weight = 250 }, -- Wind Torque
    },

    {
        { item = xi.item.PLATINUM_BEASTCOIN,     weight = 500 }, -- Platinum Beastcoin
        { item = xi.item.SCROLL_OF_ABSORB_STR,   weight =  48 }, -- Scroll Of Absorb-STR
        { item = xi.item.SCROLL_OF_ERASE,        weight = 143 }, -- Scroll Of Erase
        { item = xi.item.SCROLL_OF_PHALANX,      weight = 119 }, -- Scroll Of Phalanx
        { item = xi.item.FIRE_SPIRIT_PACT,       weight =  48 }, -- Fire Spirit Pact
        { item = xi.item.CHUNK_OF_FIRE_ORE,      weight =  48 }, -- Chunk Of Fire Ore
        { item = xi.item.CHUNK_OF_ICE_ORE,       weight =  48 }, -- Chunk Of Ice Ore
        { item = xi.item.CHUNK_OF_WIND_ORE,      weight =  48 }, -- Chunk Of Wind Ore
        { item = xi.item.CHUNK_OF_EARTH_ORE,     weight =  48 }, -- Chunk Of Earth Ore
        { item = xi.item.CHUNK_OF_LIGHTNING_ORE, weight =  48 }, -- Chunk Of Lightning Ore
        { item = xi.item.CHUNK_OF_WATER_ORE,     weight =  48 }, -- Chunk Of Water Ore
        { item = xi.item.CHUNK_OF_LIGHT_ORE,     weight =  48 }, -- Chunk Of Light Ore
        { item = xi.item.CHUNK_OF_DARK_ORE,      weight =  48 }, -- Chunk Of Dark Ore
    },

    {
        { item = xi.item.PLATINUM_BEASTCOIN, weight = 833 }, -- Platinum Beastcoin
        { item = xi.item.CHUNK_OF_ICE_ORE,   weight = 167 }, -- Chunk Of Ice Ore
    },

    {
        { item = xi.item.ENFEEBLING_TORQUE, weight = 250 }, -- Enfeebling Torque
        { item = xi.item.EVASION_TORQUE,    weight = 250 }, -- Evasion Torque
        { item = xi.item.GUARDING_TORQUE,   weight = 250 }, -- Guarding Torque
        { item = xi.item.SUMMONING_TORQUE,  weight = 250 }, -- Summoning Torque
    },

    {
        { item = xi.item.DARKSTEEL_INGOT,    weight = 154 }, -- Darksteel Ingot
        { item = xi.item.PAINITE,            weight = 154 }, -- Painite
        { item = xi.item.GOLD_INGOT,         weight = 154 }, -- Gold Ingot
        { item = xi.item.AQUAMARINE,         weight =  77 }, -- Aquamarine
        { item = xi.item.VILE_ELIXIR_P1,     weight =  77 }, -- Vile Elixir +1
        { item = xi.item.MYTHRIL_INGOT,      weight = 153 }, -- Mythril Ingot
        { item = xi.item.CHRYSOBERYL,        weight =  30 }, -- Chrysoberyl
        { item = xi.item.MOONSTONE,          weight =  30 }, -- Moonstone
        { item = xi.item.SUNSTONE,           weight =  30 }, -- Sunstone
        { item = xi.item.ZIRCON,             weight =  30 }, -- Zircon
        { item = xi.item.AQUAMARINE,         weight =  30 }, -- Aquamarine
        { item = xi.item.EBONY_LOG,          weight =  30 }, -- Ebony Log
        { item = xi.item.MAHOGANY_LOG,       weight =  30 }, -- Mahogany Log
        { item = xi.item.PHILOSOPHERS_STONE, weight =  30 }, -- Philosophers Stone
    },

    {
        { item = xi.item.DARKSTEEL_INGOT,            weight =  77 }, -- Darksteel Ingot
        { item = xi.item.MOONSTONE,                  weight = 134 }, -- Moonstone
        { item = xi.item.STEEL_INGOT,                weight = 154 }, -- Steel Ingot
        { item = xi.item.CHRYSOBERYL,                weight =  50 }, -- Chrysoberyl
        { item = xi.item.HI_RERAISER,                weight = 154 }, -- Hi-reraiser
        { item = xi.item.JADEITE,                    weight = 121 }, -- Jadeite
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  10 }, -- Spool Of Malboro Fiber
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  10 }, -- Vial Of Black Beetle Blood
        { item = xi.item.RED_ROCK,                   weight =  30 }, -- Red Rock
        { item = xi.item.BLUE_ROCK,                  weight =  30 }, -- Blue Rock
        { item = xi.item.YELLOW_ROCK,                weight =  30 }, -- Yellow Rock
        { item = xi.item.GREEN_ROCK,                 weight =  30 }, -- Green Rock
        { item = xi.item.TRANSLUCENT_ROCK,           weight =  30 }, -- Translucent Rock
        { item = xi.item.PURPLE_ROCK,                weight =  30 }, -- Purple Rock
        { item = xi.item.BLACK_ROCK,                 weight =  30 }, -- Black Rock
        { item = xi.item.WHITE_ROCK,                 weight =  30 }, -- White Rock
        { item = xi.item.FLUORITE,                   weight =  50 }, -- Fluorite
    },
}

return content:register()
