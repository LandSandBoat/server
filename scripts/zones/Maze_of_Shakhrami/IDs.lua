-----------------------------------
-- Area: Maze of Shakhrami (198)
-----------------------------------
zones = zones or {}

zones[xi.zone.MAZE_OF_SHAKHRAMI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6409,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6424,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7017,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        FOSSIL_EXTRACTED              = 7073,  -- A large fossil has been excavated from here.
        NOTHING_FOSSIL                = 7074,  -- It looks like a rock with fossils embedded in it. Nothing out of the ordinary.
        NO_NEED_INVESTIGATE           = 7078,  -- There is no need to investigate it any further.
        JUST_A_ROCK                   = 7081,  -- It is just a rock. There is no need to investigate it.
        PILE_OF_COINS                 = 7082,  -- Inside, there is a pile of coins with constellations drawn on them.
        LOOKS_EMPTY                   = 7083,  -- The chest looks empty.
        TOO_RUSTY_TO_OPEN             = 7084,  -- The chest is too rusty to open.
        BROKEN_LOCK                   = 7085,  -- The lock is broken and cannot be opened.
        SUBMERGED_ITEM                = 7096,  -- You submerged the <item> into the pool of water.
        MORE_THAN_ONE                 = 7097,  -- You cannot submerge more than one <item> at a time.
        WATER_POOL                    = 7098,  -- Water forms a pool here.
        WAIT_A_BIT_LONGER             = 7099,  -- It does not seem to have become <item> yet. You need to wait a bit longer.
        CONQUEST_BASE                 = 7101,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7166,  -- San d'Oria's region points have increased!
        DEVICE_NOT_WORKING            = 7274,  -- The device is not working.
        SYS_OVERLOAD                  = 7283,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7288,  -- You lost the <item>.
        MIGHT_BE_ABLE_TO_OPEN         = 7291,  -- You might be able to open it if you had the key.
        CRUBLES_TO_DUST               = 7292,  -- The <item> crumbles into dust.
        OINTMENT_DRAWS_MONSTERS       = 7324,  -- The ointment's odor draws out the monsters!
        CHEST_UNLOCKED                = 7379,  -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE       = 7387,  -- Mining is possible here if you have <item>.
        ITEMS_ITEMS_LA_LA             = 7397,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7403,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 8287,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8288,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8289,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8290,  -- You already possess that temporary item.
        NO_COMBINATION                = 8295,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10373, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11445, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        QM_RSE             = GetFirstID('qm1'),
        FOSSIL_ROCK_OFFSET = GetFirstID('Fossil_Rock'),
        TREASURE_CHEST     = GetFirstID('Treasure_Chest'),
        EXCAVATION         = GetTableOfIDs('Excavation_Point'),
    },
}

return zones[xi.zone.MAZE_OF_SHAKHRAMI]
