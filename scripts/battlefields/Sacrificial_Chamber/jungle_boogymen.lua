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
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY,      -- Sable-tongued Gonberry
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 1,  -- Virid-faced Shanberry
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 2,  -- Cyaneous-toed Yallberry
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 3,  -- Vermilion-eared Nobberry
            },

            {
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 7,  -- Sable-tongued Gonberry
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 8,  -- Virid-faced Shanberry
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 9,  -- Cyaneous-toed Yallberry
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 10, -- Vermilion-eared Nobberry
            },

            {
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 14, -- Sable-tongued Gonberry
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 15, -- Virid-faced Shanberry
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 16, -- Cyaneous-toed Yallberry
                sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 17, -- Vermilion-eared Nobberry
            },
        },

        superlink = true,
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobIds =
        {
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 5  }, -- Tonberry's Elemental
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 12 }, -- Tonberry's Elemental
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 19 }, -- Tonberry's Elemental
        },
    },

    {
        mobIds =
        {
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 6  }, -- Tonberry's Avatar
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 13 }, -- Tonberry's Avatar
            { sacrificialChamberID.mob.SABLE_TONGUED_GONBERRY + 20 }, -- Tonberry's Avatar
        },

        spawned = false,
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                    weight = 10000, amount = 18000 },
    },

    {
        { itemId = xi.item.DARK_TORQUE,            weight =  2500 },
        { itemId = xi.item.ELEMENTAL_TORQUE,       weight =  2500 },
        { itemId = xi.item.HEALING_TORQUE,         weight =  2500 },
        { itemId = xi.item.WIND_TORQUE,            weight =  2500 },
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
        { itemId = xi.item.CHUNK_OF_LIGHT_ORE,     weight =   500 },
        { itemId = xi.item.CHUNK_OF_LIGHTNING_ORE, weight =   500 },
        { itemId = xi.item.CHUNK_OF_WATER_ORE,     weight =   500 },
        { itemId = xi.item.CHUNK_OF_WIND_ORE,      weight =   500 },
    },

    {
        { itemId = xi.item.ENFEEBLING_TORQUE,      weight =  2500 },
        { itemId = xi.item.EVASION_TORQUE,         weight =  2500 },
        { itemId = xi.item.GUARDING_TORQUE,        weight =  2500 },
        { itemId = xi.item.SUMMONING_TORQUE,       weight =  2500 },
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
