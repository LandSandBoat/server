-----------------------------------
-- Area: Maze of Shakhrami (198)
-----------------------------------
zones = zones or {}

zones[xi.zone.MAZE_OF_SHAKHRAMI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6420,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7013,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        FOSSIL_EXTRACTED              = 7068,  -- A large fossil has been excavated from here.
        NOTHING_FOSSIL                = 7069,  -- It looks like a rock with fossils embedded in it. Nothing out of the ordinary.
        NO_NEED_INVESTIGATE           = 7073,  -- There is no need to investigate it any further.
        JUST_A_ROCK                   = 7076,  -- It is just a rock. There is no need to investigate it.
        PILE_OF_COINS                 = 7077,  -- Inside, there is a pile of coins with constellations drawn on them.
        LOOKS_EMPTY                   = 7078,  -- The chest looks empty.
        TOO_RUSTY_TO_OPEN             = 7079,  -- The chest is too rusty to open.
        BROKEN_LOCK                   = 7080,  -- The lock is broken and cannot be opened.
        SUBMERGED_ITEM                = 7091,  -- You submerged the <item> into the pool of water.
        MORE_THAN_ONE                 = 7092,  -- You cannot submerge more than one <item> at a time.
        WATER_POOL                    = 7093,  -- Water forms a pool here.
        WAIT_A_BIT_LONGER             = 7094,  -- It does not seem to have become <item> yet. You need to wait a bit longer.
        CONQUEST_BASE                 = 7096,  -- Tallying conquest results...
        DEVICE_NOT_WORKING            = 7269,  -- The device is not working.
        SYS_OVERLOAD                  = 7278,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7283,  -- You lost the <item>.
        MIGHT_BE_ABLE_TO_OPEN         = 7286,  -- You might be able to open it if you had the key.
        CRUBLES_TO_DUST               = 7287,  -- The <item> crumbles into dust.
        CHEST_UNLOCKED                = 7374,  -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE       = 7382,  -- Mining is possible here if you have <item>.
        ITEMS_ITEMS_LA_LA             = 7392,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7398,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 8282,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8283,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8284,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8285,  -- You already possess that temporary item.
        NO_COMBINATION                = 8290,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10368, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11440, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
