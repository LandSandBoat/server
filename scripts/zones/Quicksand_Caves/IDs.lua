-----------------------------------
-- Area: Quicksand_Caves
-----------------------------------
zones = zones or {}

zones[xi.zone.QUICKSAND_CAVES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405,  -- You are suddenly overcome with a sense of foreboding...
        NOW_IS_NOT_THE_TIME           = 6406,  -- Now is not the time for that!
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7219,  -- You can't fish here.
        CHEST_UNLOCKED                = 7327,  -- You unlock the chest!
        DOOR_FIRMLY_SHUT              = 7335,  -- The door is firmly shut.
        ANCIENT_LETTERS_UNREAD        = 7344,  -- Ancient letters are carved here, but you are unable to read them.
        POOL_OF_WATER                 = 7367,  -- It is a pool of water.
        SENSE_SOMETHING_EVIL          = 7368,  -- You sense something evil.
        YOU_FIND_NOTHING_OUT          = 7369,  -- You find nothing out of the ordinary.
        YOU_FIND_NOTHING              = 7370,  -- You find nothing.
        SOMETHING_ATTACKING_YOU       = 7374,  -- Something is attacking from behind you!
        SOMETHING_IS_BURIED           = 7375,  -- Something is buried in this fallen pillar.
        SENSE_OMINOUS_PRESENCE        = 7379,  -- You sense an ominous presence...
        PLAYER_OBTAINS_ITEM           = 8287,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8288,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8289,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8290,  -- You already possess that temporary item.
        NO_COMBINATION                = 8295,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10373, -- New training regime registered!
        HOMEPOINT_SET                 = 11435, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 11493, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        SAGITTARIUS_X_XIII_PH   =
        {
            [17629296] = 17629301, -- 641 -16.786 -774
        },
        NUSSKNACKER_PH          =
        {
            [17629396] = 17629403, -- 189 2 4
            [17629397] = 17629403, -- 200 2 -4
        },
        CENTURIO_X_I_PH         =
        {
            [17629237] = 17629238, -- 773.581 1.576 -568.904
        },
        ANTICAN_MAGISTER_PH     =
        {
            [17629280] = 17629280, -- 856.187 1.120 -657.310
        },
        ANTICAN_PRAEFECTUS_PH   =
        {
            [17629280] = 17629281, -- -90.01 -0.567 -29.424
        },
        ANTICAN_PROCONSUL_PH    =
        {
            [17629420] = 17629421, -- 89.575 -0.299 -196.206
        },
        DIAMOND_DAIG_PH         =
        {
            [17629439] = 17629430, -- -95.632 -0.5 -214.732
        },
        ANTICAN_TRIBUNUS_PH     =
        {
            [17629501] = 17629483, -- -575.455 -0.401 -433.802
        },
        TRIARIUS_X_XV_PH        =
        {
            [17629533] = 17629524, -- -786.730 -0.5 -343.963
        },
        HASTATUS_XI_XII_PH      =
        {
            [17629557] = 17629561, -- -343.859 -0.411 751.608
        },
        SABOTENDER_BAILARIN_PH  =
        {
            [17629261] = 17629264, -- 604 -5.5 -680
            [17629262] = 17629264, -- 600 -5.5 -673
        },
        SABOTENDER_BAILARINA_PH =
        {
            [17629582] = 17629587, -- -458 0 780
            [17629586] = 17629587, -- -522 1 779
        },
        VALOR                 = 17629185,
        HONOR                 = 17629186,
        CENTURIO_IV_VII       = 17629187,
        TRIARIUS_IV_XIV       = 17629188,
        PRINCEPS_IV_XLV       = 17629189,
        MIMIC                 = 17629190,
        ANCIENT_VESSEL        = 17629642,
        TRIBUNUS_VII_I        = 17629643,
        GIRTABLULU            = 17629645,
    },
    npc =
    {
        ANTICAN_TAG_POSITIONS =
        {
            [1] = { 590.000,  -6.600, -663.000 },
            [2] = { 748.000,   2.000, -570.000 },
            [3] = { 479.000, -14.000, -815.000 },
            [4] = { 814.000, -14.000, -761.000 },
        },

        ORNATE_DOOR_OFFSET     = 17629693,
        CHAINS_THAT_BIND_US_QM = 17629746,
        TREASURE_COFFER        = 17629747,
        ANTICAN_TAG_QM         = 17629769,
    },
}

return zones[xi.zone.QUICKSAND_CAVES]
