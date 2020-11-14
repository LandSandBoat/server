-----------------------------------
-- Area: Garlaige Citadel (200)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.GARLAIGE_CITADEL] =
{
    text =
    {
        CONQUEST_BASE               = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED     = 6541,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6547,  -- Obtained: <item>.
        GIL_OBTAINED                = 6548,  -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6550,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY     = 6561,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING         = 6562,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET       = 6576,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS         = 7158, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY     = 7159, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER                = 7160, -- In celebration of your most recent login no. <number>...
        GEOMAGNETRON_ATTUNED        = 7169,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        DEVICE_NOT_WORKING          = 7233,  -- The device is not working.
        SYS_OVERLOAD                = 7242,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                = 7247,  -- You lost the <item>.
        SPARKLING_LIGHT             = 7259,  -- The ground is sparkling with a strange light.
        A_GATE_OF_STURDY_STEEL      = 7271,  -- A gate of sturdy steel.
        OPEN_WITH_THE_RIGHT_KEY     = 7277,  -- You might be able to open it with the right key.
        BANISHING_GATES             = 7286,  -- The first banishing gate begins to open...
        BANISHING_GATES_CLOSING     = 7289,  -- The first banishing gate starts to close.
        YOU_FIND_NOTHING            = 7293,  -- You find nothing special.
        HOLE_IN_THE_CEILING         = 7294,  -- There is a hole in the ceiling.
        PRESENCE_FROM_CEILING       = 7295,  -- You sense a presence from in the ceiling.
        HEAT_FROM_CEILING           = 7296,  -- You feel a terrible heat from the ceiling.
        THE_PRESENCE_MOVES          = 7300,  -- The presence in the ceiling seems to have moved to the east.
        CHEST_UNLOCKED              = 7326,  -- You unlock the chest!
        ITEMS_ITEMS_LA_LA           = 7453,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY         = 7459,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM         = 7519,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM       = 7520,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM    = 7521,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP        = 7522,  -- You already possess that temporary item.
        NO_COMBINATION              = 7527,  -- You were unable to enter a combination.
        REGIME_REGISTERED           = 9605,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL       = 11556, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        HAZMAT_PH =
        {
            [17596515] = 17596520,
        },
        HOVERING_HOTPOT_PH =
        {
            [17596623] = 17596628, -- 182.157 -0.012 29.941
            [17596625] = 17596628, -- 188.229 -0.018 20.151
        },
        OLD_TWO_WINGS       = 17596506,
        SKEWER_SAM          = 17596507,
        CHANDELIER          = 17596533,
        GUARDIAN_STATUE     = 17596643,
        SERKET              = 17596720,
        MIMIC               = 17596728,
        APPARATUS_ELEMENTAL = 17596729,
    },
    npc =
    {
        CASKET_BASE           = 17596738,
        BANISHING_GATE_OFFSET = 17596761,
        TREASURE_CHEST        = 17596812,
        TREASURE_COFFER       = 17596813,
        CHANDELIER_QM         = 17596830,
    },
}

return zones[tpz.zone.GARLAIGE_CITADEL]
