-----------------------------------
-- Area: Kuftal_Tunnel
-----------------------------------
zones = zones or {}

zones[xi.zone.KUFTAL_TUNNEL] =
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
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7061,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7220,  -- You can't fish here.
        CHEST_UNLOCKED                = 7328,  -- You unlock the chest!
        DO_NOT_SEE_ANYTHING           = 7343,  -- You do not see anything out of the ordinary.
        FELL                          = 7346,  -- The piece of wood fell off the cliff!
        EVIL                          = 7347,  -- You sense an evil presence...
        FISHBONES                     = 7361,  -- Fish bones lie scattered about the area...
        SENSE_OMINOUS_PRESENCE        = 7363,  -- You sense an ominous presence...
        REGIME_REGISTERED             = 10347, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11399, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11400, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11401, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11402, -- You already possess that temporary item.
        NO_COMBINATION                = 11407, -- You were unable to enter a combination.
        COMMON_SENSE_SURVIVAL         = 11431, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 11495, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        AMEMET_PH               =
        {
            [17490000] = 17490016, -- 123.046 0.250 18.642
            [17489994] = 17490016, -- 112.135 -0.278 38.281
            [17490001] = 17490016, -- 112.008 -0.530 50.994
            [17490003] = 17490016, -- 122.654 -0.491 0.840
            [17490008] = 17490016, -- 123.186 0.213 -24.716
            [17490005] = 17490016, -- 118.633 -0.470 -43.282
            [17490010] = 17490016, -- 109.000 -0.010 -48.000
            [17490004] = 17490016, -- 96.365 -0.269 -7.619
            [17490002] = 17490016, -- 89.590 -0.321 -9.390
            [17489933] = 17490016, -- 68.454 -0.417 -0.413
            [17489932] = 17490016, -- 74.662 -0.513 3.685
            [17490009] = 17490016, -- 67.998 -0.500 12.000
            [17489934] = 17490016, -- 92.000 -0.396 14.000
        },
        ARACHNE_PH              =
        {
            [17490222] = 17490217, -- 19.000 20.000 37.000
            [17490221] = 17490217, -- -10.000 20.000 14.000
            [17490219] = 17490217, -- -20.000 20.000 38.000
            [17490220] = 17490217, -- -20.000 21.000 1.000
        },
        BLOODTHIRSTER_MADKIX_PH =
        {
            [17490173] = 17490159, -- 265.000 9.000 30.000
            [17490182] = 17490159, -- 256.000 10.000 34.000
        },
        PELICAN_PH              =
        {
            [17490097] = 17490101, -- 178.857 20.256 -44.151
            [17490094] = 17490101, -- 180.000 21.000 -39.000
            [17490098] = 17490101, -- 179.394 20.061 -34.062
        },
        SABOTENDER_MARIACHI_PH  =
        {
            [17489987] = 17489980, -- -23.543 -0.396 59.578
            [17489983] = 17489980, -- -45.000 -0.115 39.000
            [17489985] = 17489980, -- -34.263 -0.512 30.437
            [17489984] = 17489980, -- -38.791 0.230 26.579
            [17489977] = 17489980, -- -41.000 0.088 -3.000
            [17489978] = 17489980, -- -54.912 0.347 -1.681
            [17489979] = 17489980, -- -58.807 -0.327 -8.531
            [17489981] = 17489980, -- -82.074 -0.450 -0.738
            [17489982] = 17489980, -- -84.721 -0.325 -2.861
            [17489974] = 17489980, -- -41.000 -0.488 -31.000
            [17489975] = 17489980, -- -33.717 -0.448 -43.478
            [17489971] = 17489980, -- -17.217 -0.956 -57.647
        },
        YOWIE_PH                =
        {
            [17490175] = 17490204, -- 27.000 19.000 132.000
            [17490174] = 17490204, -- 20.000 20.000 118.000
            [17490168] = 17490204, -- 19.000 18.000 100.000
            [17490167] = 17490204, -- 18.000 21.000 82.000
            [17490161] = 17490204, -- 23.000 20.000 75.000
            [17490176] = 17490204, -- 19.000 19.000 55.000
            [17490160] = 17490204, -- 34.000 21.000 59.000
            [17490146] = 17490204, -- 59.000 21.000 65.000
            [17490148] = 17490204, -- 58.000 21.000 57.000
            [17490144] = 17490204, -- 72.000 21.000 63.000
            [17490141] = 17490204, -- 87.000 21.000 59.000
        },
        TALEKEEPER_OFFSET       = 17489926,
        MIMIC                   = 17490230,
        CANCER                  = 17490231,
        PHANTOM_WORM            = 17490233,
        GUIVRE                  = 17490234,
        KETTENKAEFER            = 17490235,
    },
    npc =
    {
        PHANTOM_WORM_QM = 17490253,
        DOOR_ROCK       = 17490280,
        TREASURE_COFFER = 17490304,
    },
}

return zones[xi.zone.KUFTAL_TUNNEL]
