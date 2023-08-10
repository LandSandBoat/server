-----------------------------------
-- Area: Garlaige Citadel (200)
-----------------------------------
zones = zones or {}

zones[xi.zone.GARLAIGE_CITADEL] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6563,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6564,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6578,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7160,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7161,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7162,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7171,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7182,  -- Your party is unable to participate because certain members' levels are restricted.
        DEVICE_NOT_WORKING            = 7244,  -- The device is not working.
        SYS_OVERLOAD                  = 7253,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7258,  -- You lost the <item>.
        SPARKLING_LIGHT               = 7270,  -- The ground is sparkling with a strange light.
        A_GATE_OF_STURDY_STEEL        = 7282,  -- A gate of sturdy steel.
        OPEN_WITH_THE_RIGHT_KEY       = 7288,  -- You might be able to open it with the right key.
        BANISHING_GATES               = 7297,  -- The first banishing gate begins to open...
        BANISHING_GATES_CLOSING       = 7300,  -- The first banishing gate starts to close.
        YOU_FIND_NOTHING              = 7304,  -- You find nothing special.
        HOLE_IN_THE_CEILING           = 7305,  -- There is a hole in the ceiling.
        PRESENCE_FROM_CEILING         = 7306,  -- You sense a presence from in the ceiling.
        HEAT_FROM_CEILING             = 7307,  -- You feel a terrible heat from the ceiling.
        THE_PRESENCE_MOVES            = 7311,  -- The presence in the ceiling seems to have moved to the east.
        CHEST_UNLOCKED                = 7337,  -- You unlock the chest!
        ITEMS_ITEMS_LA_LA             = 7464,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7470,  -- The Goblin slipped away when you were not looking...
        YOU_COULD_OPEN_THE_GATE       = 7522,  -- If only you had %, you could open the banishing gate...
        THE_GATE_OPENS_FOR_YOU        = 7523,  -- By the power of your %, the gate opens for you.
        COMBINE_INTO_A_CHUNK          = 7525,  -- You combine the % you have collected into a single chunk.
        PLAYER_OBTAINS_ITEM           = 7530,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7531,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7532,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7533,  -- You already possess that temporary item.
        NO_COMBINATION                = 7538,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9616,  -- New training regime registered!
        LEARNS_SPELL                  = 11534, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11536, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11567, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 11631, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
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
        BANISHING_GATE_OFFSET = 17596761,
        TREASURE_CHEST        = 17596812,
        TREASURE_COFFER       = 17596813,
        CHANDELIER_QM         = 17596830,
    },
}

return zones[xi.zone.GARLAIGE_CITADEL]
