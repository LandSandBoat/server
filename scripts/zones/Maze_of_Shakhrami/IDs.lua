-----------------------------------
-- Area: Maze of Shakhrami (198)
-----------------------------------
zones = zones or {}

zones[xi.zone.MAZE_OF_SHAKHRAMI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6393,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6394,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6396,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6407,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6422,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7004,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7005,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7006,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7015,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7026,  -- Your party is unable to participate because certain members' levels are restricted.
        FOSSIL_EXTRACTED              = 7071,  -- A large fossil has been excavated from here.
        NOTHING_FOSSIL                = 7072,  -- It looks like a rock with fossils embedded in it. Nothing out of the ordinary.
        NO_NEED_INVESTIGATE           = 7076,  -- There is no need to investigate it any further.
        JUST_A_ROCK                   = 7079,  -- It is just a rock. There is no need to investigate it.
        PILE_OF_COINS                 = 7080,  -- Inside, there is a pile of coins with constellations drawn on them.
        LOOKS_EMPTY                   = 7081,  -- The chest looks empty.
        TOO_RUSTY_TO_OPEN             = 7082,  -- The chest is too rusty to open.
        BROKEN_LOCK                   = 7083,  -- The lock is broken and cannot be opened.
        SUBMERGED_ITEM                = 7094,  -- You submerged the <item> into the pool of water.
        MORE_THAN_ONE                 = 7095,  -- You cannot submerge more than one <item> at a time.
        WATER_POOL                    = 7096,  -- Water forms a pool here.
        WAIT_A_BIT_LONGER             = 7097,  -- It does not seem to have become <item> yet. You need to wait a bit longer.
        CONQUEST_BASE                 = 7099,  -- Tallying conquest results...
        EXP_FORCE_CHEST_SANDORIA      = 7164,  -- San d'Oria's region points have increased!
        EXP_FORCE_CHEST_BASTOK        = 7165,  -- Bastok's region points have increased!
        EXP_FORCE_CHEST_WINDURST      = 7166,  -- Windurst's region points have increased!
        DEVICE_NOT_WORKING            = 7272,  -- The device is not working.
        SYS_OVERLOAD                  = 7281,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7286,  -- You lost the <item>.
        MIGHT_BE_ABLE_TO_OPEN         = 7289,  -- You might be able to open it if you had the key.
        CRUBLES_TO_DUST               = 7290,  -- The <item> crumbles into dust.
        CHEST_UNLOCKED                = 7377,  -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE       = 7385,  -- Mining is possible here if you have <item>.
        ITEMS_ITEMS_LA_LA             = 7395,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7401,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 8285,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8286,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8287,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8288,  -- You already possess that temporary item.
        NO_COMBINATION                = 8293,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10371, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11443, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
