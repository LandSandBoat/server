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
        { itemId = xi.item.DARK_TORQUE,      weight = 250 }, -- Dark Torque
        { itemId = xi.item.ELEMENTAL_TORQUE, weight = 250 }, -- Elemental Torque
        { itemId = xi.item.HEALING_TORQUE,   weight = 250 }, -- Healing Torque
        { itemId = xi.item.WIND_TORQUE,      weight = 250 }, -- Wind Torque
    },

    {
        { itemId = xi.item.PLATINUM_BEASTCOIN,     weight = 500 }, -- Platinum Beastcoin
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,   weight =  48 }, -- Scroll Of Absorb-STR
        { itemId = xi.item.SCROLL_OF_ERASE,        weight = 143 }, -- Scroll Of Erase
        { itemId = xi.item.SCROLL_OF_PHALANX,      weight = 119 }, -- Scroll Of Phalanx
        { itemId = xi.item.FIRE_SPIRIT_PACT,       weight =  48 }, -- Fire Spirit Pact
        { itemId = xi.item.CHUNK_OF_FIRE_ORE,      weight =  48 }, -- Chunk Of Fire Ore
        { itemId = xi.item.CHUNK_OF_ICE_ORE,       weight =  48 }, -- Chunk Of Ice Ore
        { itemId = xi.item.CHUNK_OF_WIND_ORE,      weight =  48 }, -- Chunk Of Wind Ore
        { itemId = xi.item.CHUNK_OF_EARTH_ORE,     weight =  48 }, -- Chunk Of Earth Ore
        { itemId = xi.item.CHUNK_OF_LIGHTNING_ORE, weight =  48 }, -- Chunk Of Lightning Ore
        { itemId = xi.item.CHUNK_OF_WATER_ORE,     weight =  48 }, -- Chunk Of Water Ore
        { itemId = xi.item.CHUNK_OF_LIGHT_ORE,     weight =  48 }, -- Chunk Of Light Ore
        { itemId = xi.item.CHUNK_OF_DARK_ORE,      weight =  48 }, -- Chunk Of Dark Ore
    },

    {
        { itemId = xi.item.PLATINUM_BEASTCOIN, weight = 833 }, -- Platinum Beastcoin
        { itemId = xi.item.CHUNK_OF_ICE_ORE,   weight = 167 }, -- Chunk Of Ice Ore
    },

    {
        { itemId = xi.item.ENFEEBLING_TORQUE, weight = 250 }, -- Enfeebling Torque
        { itemId = xi.item.EVASION_TORQUE,    weight = 250 }, -- Evasion Torque
        { itemId = xi.item.GUARDING_TORQUE,   weight = 250 }, -- Guarding Torque
        { itemId = xi.item.SUMMONING_TORQUE,  weight = 250 }, -- Summoning Torque
    },

    {
        { itemId = xi.item.DARKSTEEL_INGOT,    weight = 154 }, -- Darksteel Ingot
        { itemId = xi.item.PAINITE,            weight = 154 }, -- Painite
        { itemId = xi.item.GOLD_INGOT,         weight = 154 }, -- Gold Ingot
        { itemId = xi.item.AQUAMARINE,         weight =  77 }, -- Aquamarine
        { itemId = xi.item.VILE_ELIXIR_P1,     weight =  77 }, -- Vile Elixir +1
        { itemId = xi.item.MYTHRIL_INGOT,      weight = 153 }, -- Mythril Ingot
        { itemId = xi.item.CHRYSOBERYL,        weight =  30 }, -- Chrysoberyl
        { itemId = xi.item.MOONSTONE,          weight =  30 }, -- Moonstone
        { itemId = xi.item.SUNSTONE,           weight =  30 }, -- Sunstone
        { itemId = xi.item.ZIRCON,             weight =  30 }, -- Zircon
        { itemId = xi.item.AQUAMARINE,         weight =  30 }, -- Aquamarine
        { itemId = xi.item.EBONY_LOG,          weight =  30 }, -- Ebony Log
        { itemId = xi.item.MAHOGANY_LOG,       weight =  30 }, -- Mahogany Log
        { itemId = xi.item.PHILOSOPHERS_STONE, weight =  30 }, -- Philosophers Stone
    },

    {
        { itemId = xi.item.DARKSTEEL_INGOT,            weight =  77 }, -- Darksteel Ingot
        { itemId = xi.item.MOONSTONE,                  weight = 134 }, -- Moonstone
        { itemId = xi.item.STEEL_INGOT,                weight = 154 }, -- Steel Ingot
        { itemId = xi.item.CHRYSOBERYL,                weight =  50 }, -- Chrysoberyl
        { itemId = xi.item.HI_RERAISER,                weight = 154 }, -- Hi-reraiser
        { itemId = xi.item.JADEITE,                    weight = 121 }, -- Jadeite
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  10 }, -- Spool Of Malboro Fiber
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  10 }, -- Vial Of Black Beetle Blood
        { itemId = xi.item.RED_ROCK,                   weight =  30 }, -- Red Rock
        { itemId = xi.item.BLUE_ROCK,                  weight =  30 }, -- Blue Rock
        { itemId = xi.item.YELLOW_ROCK,                weight =  30 }, -- Yellow Rock
        { itemId = xi.item.GREEN_ROCK,                 weight =  30 }, -- Green Rock
        { itemId = xi.item.TRANSLUCENT_ROCK,           weight =  30 }, -- Translucent Rock
        { itemId = xi.item.PURPLE_ROCK,                weight =  30 }, -- Purple Rock
        { itemId = xi.item.BLACK_ROCK,                 weight =  30 }, -- Black Rock
        { itemId = xi.item.WHITE_ROCK,                 weight =  30 }, -- White Rock
        { itemId = xi.item.FLUORITE,                   weight =  50 }, -- Fluorite
    },
}

return content:register()
