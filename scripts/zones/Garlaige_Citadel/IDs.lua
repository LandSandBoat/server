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
        DEVICE_NOT_WORKING            = 7251,  -- The device is not working.
        SYS_OVERLOAD                  = 7260,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7265,  -- You lost the <item>.
        SPARKLING_LIGHT               = 7277,  -- The ground is sparkling with a strange light.
        A_GATE_OF_STURDY_STEEL        = 7289,  -- A gate of sturdy steel.
        OPEN_WITH_THE_RIGHT_KEY       = 7295,  -- You might be able to open it with the right key.
        BANISHING_GATES               = 7304,  -- The first banishing gate begins to open...
        BANISHING_GATES_CLOSING       = 7307,  -- The first banishing gate starts to close.
        YOU_FIND_NOTHING              = 7311,  -- You find nothing special.
        HOLE_IN_THE_CEILING           = 7312,  -- There is a hole in the ceiling.
        PRESENCE_FROM_CEILING         = 7313,  -- You sense a presence from in the ceiling.
        HEAT_FROM_CEILING             = 7314,  -- You feel a terrible heat from the ceiling.
        THE_PRESENCE_MOVES            = 7318,  -- The presence in the ceiling seems to have moved to the east.
        CHEST_UNLOCKED                = 7344,  -- You unlock the chest!
        ITEMS_ITEMS_LA_LA             = 7471,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7477,  -- The Goblin slipped away when you were not looking...
        YOU_COULD_OPEN_THE_GATE       = 7529,  -- If only you had %, you could open the banishing gate...
        THE_GATE_OPENS_FOR_YOU        = 7530,  -- By the power of your %, the gate opens for you.
        COMBINE_INTO_A_CHUNK          = 7532,  -- You combine the % you have collected into a single chunk.
        PLAYER_OBTAINS_ITEM           = 7537,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7538,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7539,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7540,  -- You already possess that temporary item.
        NO_COMBINATION                = 7545,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9623,  -- New training regime registered!
        LEARNS_SPELL                  = 11541, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11543, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11574, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 11638, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        HAZMAT              = GetFirstID('Hazmat'),
        HOVERING_HOTPOT     = GetFirstID('Hovering_Hotpot'),
        OLD_TWO_WINGS       = GetFirstID('Old_Two-Wings'),
        SKEWER_SAM          = GetFirstID('Skewer_Sam'),
        CHANDELIER          = GetFirstID('Chandelier'),
        GUARDIAN_STATUE     = GetFirstID('Guardian_Statue'),
        SERKET              = GetFirstID('Serket'),
        MIMIC               = GetFirstID('Mimic'),
        APPARATUS_ELEMENTAL = GetFirstID('Light_Elemental'),
    },
    npc =
    {
        BANISHING_GATE_OFFSET = 17596762,
        TREASURE_CHEST        = GetFirstID('Treasure_Chest'),
        TREASURE_COFFER       = GetFirstID('Treasure_Coffer'),
        CHANDELIER_QM         = 17596831,
    },
}

return zones[xi.zone.GARLAIGE_CITADEL]
