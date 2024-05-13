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
        FOSSIL_EXTRACTED              = 7064,  -- A large fossil has been excavated from here.
        NOTHING_FOSSIL                = 7065,  -- It looks like a rock with fossils embedded in it. Nothing out of the ordinary.
        NO_NEED_INVESTIGATE           = 7069,  -- There is no need to investigate it any further.
        JUST_A_ROCK                   = 7072,  -- It is just a rock. There is no need to investigate it.
        CONQUEST_BASE                 = 7092,  -- Tallying conquest results...
        DEVICE_NOT_WORKING            = 7265,  -- The device is not working.
        SYS_OVERLOAD                  = 7274,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7279,  -- You lost the <item>.
        CHEST_UNLOCKED                = 7370,  -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE       = 7378,  -- Mining is possible here if you have <item>.
        ITEMS_ITEMS_LA_LA             = 7388,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7394,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 8278,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8279,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8280,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8281,  -- You already possess that temporary item.
        NO_COMBINATION                = 8286,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10364, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11436, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        TREMBLER_TABITHA    = GetFirstID('Trembler_Tabitha'),
        ICHOROUS_IRE        = GetFirstID('Ichorous_Ire'),
        ARGUS               = GetFirstID('Argus'),
        LEECH_KING          = GetFirstID('Leech_King'),
        WYRMFLY_OFFSET      = GetFirstID('Wyrmfly'),
        APPARATUS_ELEMENTAL = GetFirstID('Dark_Elemental'),
        AROMA_CRAWLER       = GetFirstID('Aroma_Crawler'),
        LOST_SOUL           = GetFirstID('Lost_Soul'),
    },
    npc =
    {
        FOSSIL_ROCK_OFFSET = GetFirstID('Fossil_Rock'),
        TREASURE_CHEST     = GetFirstID('Treasure_Chest'),
        EXCAVATION         = GetTableOfIDs('Excavation_Point'),
    },
}

return zones[xi.zone.MAZE_OF_SHAKHRAMI]
