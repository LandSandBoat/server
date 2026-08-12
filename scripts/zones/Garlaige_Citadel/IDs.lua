-----------------------------------
-- Area: Garlaige Citadel (200)
-----------------------------------
zones = zones or {}

zones[xi.zone.GARLAIGE_CITADEL] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 65,    -- San d'Oria's region points have increased!
        ITEM_CANNOT_BE_OBTAINED       = 6546,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6554,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6555,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6557,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6568,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6569,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6583,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7165,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7166,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7167,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7176,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7187,  -- Your party is unable to participate because certain members' levels are restricted.
        DEVICE_NOT_WORKING            = 7257,  -- The device is not working.
        SYS_OVERLOAD                  = 7266,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7271,  -- You lost the <item>.
        SPARKLING_LIGHT               = 7283,  -- The ground is sparkling with a strange light.
        A_GATE_OF_STURDY_STEEL        = 7295,  -- A gate of sturdy steel.
        OPEN_WITH_THE_RIGHT_KEY       = 7301,  -- You might be able to open it with the right key.
        GARLAIGE_KEY_BROKE            = 7302,  -- The <item> broke...
        BANISHING_GATES               = 7310,  -- The first banishing gate begins to open...
        BANISHING_GATES_CLOSING       = 7313,  -- The first banishing gate starts to close.
        YOU_FIND_NOTHING              = 7317,  -- You find nothing special.
        HOLE_IN_THE_CEILING           = 7318,  -- There is a hole in the ceiling.
        PRESENCE_FROM_CEILING         = 7319,  -- You sense a presence from in the ceiling.
        HEAT_FROM_CEILING             = 7320,  -- You feel a terrible heat from the ceiling.
        THE_PRESENCE_MOVES            = 7324,  -- The presence in the ceiling seems to have moved to the east.
        CHEST_UNLOCKED                = 7350,  -- You unlock the chest!
        BOXES_HERE                    = 7360,  -- Boxes are carelessly scattered here.
        BOXES_SCATTERED               = 7361,  -- Boxes are carelessly scattered here. Perhaps you could open them with %.
        FEELS_WRONG                   = 7365,  -- Something feels wrong, but nothing happens.
        ITEMS_ITEMS_LA_LA             = 7478,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7484,  -- The Goblin slipped away when you were not looking...
        YOU_COULD_OPEN_THE_GATE       = 7536,  -- If only you had %, you could open the banishing gate...
        THE_GATE_OPENS_FOR_YOU        = 7537,  -- By the power of your %, the gate opens for you.
        COMBINE_INTO_A_CHUNK          = 7539,  -- You combine the % you have collected into a single chunk.
        PLAYER_OBTAINS_ITEM           = 7544,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7545,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7546,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7547,  -- You already possess that temporary item.
        NO_COMBINATION                = 7552,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9630,  -- New training regime registered!
        LEARNS_SPELL                  = 11548, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11550, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11581, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 11645, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        APPARATUS_ELEMENTAL = GetFirstID('Light_Elemental'),
        CHANDELIER          = GetFirstID('Chandelier'),
        GUARDIAN_STATUE     = GetFirstID('Guardian_Statue'),
        HAZMAT              = GetFirstID('Hazmat'),
        HOVERING_HOTPOT     = GetFirstID('Hovering_Hotpot'),
        OLD_TWO_WINGS       = GetFirstID('Old_Two-Wings'),
        MIMIC               = GetFirstID('Mimic'),
        SERKET              = GetFirstID('Serket'),
        SKEWER_SAM          = GetFirstID('Skewer_Sam'),
    },
    npc =
    {
        BANISHING_GATE_OFFSET = GetFirstID('_5k0'),
        CHANDELIER_QM         = GetFirstID('qm15'),
        TREASURE_CHEST        = GetFirstID('Treasure_Chest'),
        TREASURE_COFFER       = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.GARLAIGE_CITADEL]
