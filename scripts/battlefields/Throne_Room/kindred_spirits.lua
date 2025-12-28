-----------------------------------
-- Area: Throne Room
-- BCNM 60 - Kindred Spirits
-- !pos -111 -6 0.1 165
-----------------------------------
local throneRoomID = zones[xi.zone.THRONE_ROOM]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.KINDRED_SPIRITS,
    maxPlayers    = 6,
    levelCap      = 60,
    timeLimit     = utils.minutes(30),
    index         = 2,
    entryNpc      = '_4l1',
    exitNpcs      = { '_4l2', '_4l3', '_4l4' },
    requiredItems = { xi.item.MOON_ORB, wearMessage = throneRoomID.text.A_CRACK_HAS_FORMED, wornMessage = throneRoomID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 4,
        throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 11,
        throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 18,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL,      -- Grand Marquis Chomiel
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 1,  -- Duke Amduscias
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 2,  -- Count Andromalius
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 3,  -- Duke Dantalian
            },

            {
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 7,  -- Grand Marquis Chomiel
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 8,  -- Duke Amduscias
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 9,  -- Count Andromalius
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 10, -- Duke Dantalian
            },

            {
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 14, -- Grand Marquis Chomiel
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 15, -- Duke Amduscias
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 16, -- Count Andromalius
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 17, -- Duke Dantalian
            },
        },

        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobIds =
        {
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 5  }, -- Demons Elemental
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 12 }, -- Demons Elemental
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 19 }, -- Demons Elemental
        },
    },

    {
        mobIds =
        {
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 6  }, -- Demons Avatar
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 13 }, -- Demons Avatar
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 20 }, -- Demons Avatar
        },

        spawned = false,
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                     weight = 10000, amount = 18000 },
    },

    {
        quantity = 3,
        { itemId = xi.item.ARCHALAUSS_POLE,         weight =   500 },
        { itemId = xi.item.ARAMISS_RAPIER,          weight =   500 },
        { itemId = xi.item.CHICKEN_KNIFE,           weight =   500 },
        { itemId = xi.item.DOMINION_MACE,           weight =   500 },
        { itemId = xi.item.DRAGVANDIL,              weight =   500 },
        { itemId = xi.item.FEY_WAND,                weight =   500 },
        { itemId = xi.item.FORSETIS_AXE,            weight =   500 },
        { itemId = xi.item.HAMELIN_FLUTE,           weight =   500 },
        { itemId = xi.item.KABRAKANS_AXE,           weight =   500 },
        { itemId = xi.item.SARNGA,                  weight =   500 },
        { itemId = xi.item.SPARTAN_CESTI,           weight =   500 },
        { itemId = xi.item.VASSAGOS_SCYTHE,         weight =   500 },
        { itemId = xi.item.ARMBRUST,                weight =   800 },
        { itemId = xi.item.LIGHT_BOOMERANG,         weight =   800 },
        { itemId = xi.item.OMOKAGE,                 weight =   800 },
        { itemId = xi.item.SAIREN,                  weight =   800 },
        { itemId = xi.item.SCHWARZ_LANCE,           weight =   800 },
    },

    {
        { itemId = xi.item.AQUAMARINE,              weight =   400 },
        { itemId = xi.item.CHRYSOBERYL,             weight =   400 },
        { itemId = xi.item.FLUORITE,                weight =   400 },
        { itemId = xi.item.JADEITE,                 weight =   400 },
        { itemId = xi.item.MOONSTONE,               weight =   400 },
        { itemId = xi.item.PAINITE,                 weight =   400 },
        { itemId = xi.item.SUNSTONE,                weight =   400 },
        { itemId = xi.item.ZIRCON,                  weight =   400 },
        { itemId = xi.item.BLACK_ROCK,              weight =   400 },
        { itemId = xi.item.BLUE_ROCK,               weight =   400 },
        { itemId = xi.item.GREEN_ROCK,              weight =   400 },
        { itemId = xi.item.PURPLE_ROCK,             weight =   400 },
        { itemId = xi.item.RED_ROCK,                weight =   400 },
        { itemId = xi.item.TRANSLUCENT_ROCK,        weight =   400 },
        { itemId = xi.item.WHITE_ROCK,              weight =   400 },
        { itemId = xi.item.YELLOW_ROCK,             weight =   400 },
        { itemId = xi.item.EBONY_LOG,               weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,            weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,         weight =   400 },
        { itemId = xi.item.GOLD_INGOT,              weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,           weight =   400 },
        { itemId = xi.item.STEEL_INGOT,             weight =   400 },
        { itemId = xi.item.DEMON_HORN,              weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,          weight =   400 },
        { itemId = xi.item.HI_RERAISER,             weight =   200 },
        { itemId = xi.item.VILE_ELIXIR_P1,          weight =   200 },
    },

    {
        { itemId = xi.item.SCROLL_OF_RERAISE_II,    weight =  2500 },
        { itemId = xi.item.SCROLL_OF_FIRE_III,      weight =  2500 },
        { itemId = xi.item.SCROLL_OF_CARNAGE_ELEGY, weight =  2500 },
        { itemId = xi.item.ICE_SPIRIT_PACT,         weight =  2500 },
    },

    {
        { itemId = xi.item.DEMON_SKULL,             weight = 10000 },
    },
}

return content:register()
