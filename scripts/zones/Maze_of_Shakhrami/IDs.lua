-----------------------------------
-- Area: Maze of Shakhrami (198)
-----------------------------------
require("scripts/globals/zone")
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
        FOSSIL_EXTRACTED              = 7060,  -- A large fossil has been excavated from here.
        NOTHING_FOSSIL                = 7061,  -- It looks like a rock with fossils embedded in it. Nothing out of the ordinary.
        NO_NEED_INVESTIGATE           = 7065,  -- There is no need to investigate it any further.
        JUST_A_ROCK                   = 7068,  -- It is just a rock. There is no need to investigate it.
        CHEST_EMPTY                   = 7070,  -- The chest looks empty.
        TOO_RUSTY                     = 7071,  -- The chest is too rusty to open.
        IRON_DOOR                     = 7072,  -- The lock is broken and cannot be opened.
        ALEXANDER_NE                  = 7075,  -- You picked up a coin with Alexander drawn to the northeast.
        SHIVA_EAST                    = 7076,  -- You picked up a coin with Shiva drawn to the east.
        ODIN_NORTH                    = 7077,  -- You picked up a coin with Odin drawn to the north.
        ODIN_EAST                     = 7078,  -- You picked up a coin with Odin drawn to the east.
        TITAN_NORTH                   = 7079,  -- You picked up a coin with Titan drawn to the north.
        LEAVIATHAN_SOUTH              = 7080,  -- You picked up a coin with Leviathan drawn to the south.
        SHIVA_WEST                    = 7081,  -- You picked up a coin with Shiva drawn to the west.
        IFRIT_NW                      = 7082,  -- You picked up a coin with Ifrit drawn to the northwest.
        SUBMERGE                      = 7083, --  You submerged the Ahriman Lens into the pool of water.
        CANNOT_SUBERMGE               = 7084, --  You cannot submerge more than one Ahriman Lens at a time.
        WATER_POOL                    = 7085, --  Water forms a pool here.
        NOT_READY                     = 7086, --  It does not seem to have become a Divination Sphere yet. You need to wait a bit longer.
        CONQUEST_BASE                 = 7088,  -- Tallying conquest results...
        DEVICE_NOT_WORKING            = 7261,  -- The device is not working.
        SYS_OVERLOAD                  = 7270,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7275,  -- You lost the <item>.
        CHEST_UNLOCKED                = 7366,  -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE       = 7374,  -- Mining is possible here if you have <item>.
        ITEMS_ITEMS_LA_LA             = 7384,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7390,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 8274,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8275,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8276,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8277,  -- You already possess that temporary item.
        NO_COMBINATION                = 8282,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10360, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11432, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        FOSSIL_ROCKS =
        {
            17588737,
            17588739,
            17588740,
            17588741,
            17588742,
            17588743,
        },
        ICHOROUS_IRE_FOSSIL_ROCK = 17588745,
        TREASURE_CHEST           = 17588773,
        EXCAVATION =
        {
            17588774,
            17588775,
            17588776,
            17588777,
            17588778,
            17588779,
        },
    },
}

return zones[xi.zone.MAZE_OF_SHAKHRAMI]
