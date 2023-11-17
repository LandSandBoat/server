-----------------------------------
-- Area: Maze of Shakhrami (198)
-----------------------------------
zones = zones or {}

zones[xi.zone.MAZE_OF_SHAKHRAMI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7012,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        FOSSIL_EXTRACTED              = 7061,  -- A large fossil has been excavated from here.
        NOTHING_FOSSIL                = 7062,  -- It looks like a rock with fossils embedded in it. Nothing out of the ordinary.
        NO_NEED_INVESTIGATE           = 7066,  -- There is no need to investigate it any further.
        JUST_A_ROCK                   = 7069,  -- It is just a rock. There is no need to investigate it.
        CONQUEST_BASE                 = 7089,  -- Tallying conquest results...
        DEVICE_NOT_WORKING            = 7262,  -- The device is not working.
        SYS_OVERLOAD                  = 7271,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7276,  -- You lost the <item>.
        CHEST_UNLOCKED                = 7367,  -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE       = 7375,  -- Mining is possible here if you have <item>.
        ITEMS_ITEMS_LA_LA             = 7385,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7391,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 8275,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8276,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8277,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8278,  -- You already possess that temporary item.
        NO_COMBINATION                = 8283,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10361, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11433, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        TREMBLER_TABITHA_PH =
        {
            [17588276] = 17588278,
            [17588277] = 17588278,
        },
        ICHOROUS_IRE        = 17588225,
        ARGUS               = 17588674,
        LEECH_KING          = 17588685,
        WYRMFLY_OFFSET      = 17588701,
        APPARATUS_ELEMENTAL = 17588704,
        AROMA_CRAWLER       = 17588705,
        LOST_SOUL           = 17588706,
    },
    npc =
    {
        FOSSIL_ROCK_OFFSET = 17588737,
        TREASURE_CHEST     = 17588773,
        EXCAVATION         = GetTableOfIDs('Excavation_Point'),
    },
}

return zones[xi.zone.MAZE_OF_SHAKHRAMI]
