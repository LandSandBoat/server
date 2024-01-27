-----------------------------------
-- Area: Crawlers_Nest
-----------------------------------
zones = zones or {}

zones[xi.zone.CRAWLERS_NEST] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        DEVICE_NOT_WORKING            = 173,   -- The device is not working.
        SYS_OVERLOAD                  = 182,   -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 187,   -- You lost the <item>.
        ITEM_CANNOT_BE_OBTAINED       = 6574,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6580,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6581,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6583,  -- Obtained key item: <keyitem>.
        SENSE_OF_FOREBODING           = 6595,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6609,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7191,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7192,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7193,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7202,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7213,  -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_UNLOCKED                = 7264,  -- You unlock the chest!
        SOMEONE_HAS_BEEN_DIGGING_HERE = 7272,  -- Someone has been digging here.
        EQUIPMENT_NOT_PURIFIED        = 7273,  -- Your equipment has not been completely purified.
        YOU_BURY_THE                  = 7275,  -- You bury the <item> and <item>.
        NOTHING_WILL_HAPPEN_YET       = 7278,  -- It seems that nothing will happen yet.
        NOTHING_SEEMS_TO_HAPPEN       = 7279,  -- Nothing seems to happen.
        COMBINE_INTO_A_CLUMP          = 7349,  -- You combine the % you have accumulated into a single clump.
        PLAYER_OBTAINS_ITEM           = 7354,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7355,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7356,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7357,  -- You already possess that temporary item.
        NO_COMBINATION                = 7362,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9440,  -- New training regime registered!
        LEARNS_SPELL                  = 11358, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11360, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11392, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DEMONIC_TIPHIA_PH =
        {
            [17584392] = 17584398, -- -103.000 -1.000 311.000
            [17584395] = 17584398, -- -89.000 -1.000 301.000
            [17584396] = 17584398, -- -75.000 -1.000 299.000
            [17584391] = 17584398, -- -101.000 -1.000 285.000
        },
        AWD_GOGGIE          = 17584135,
        DYNAST_BEETLE       = 17584312,
        DREADBUG            = 17584425,
        MIMIC               = 17584426,
        APPARATUS_ELEMENTAL = 17584427,
    },
    npc =
    {
        TREASURE_CHEST  = 17584475,
        TREASURE_COFFER = 17584476,
    },
}

return zones[xi.zone.CRAWLERS_NEST]
