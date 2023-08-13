-----------------------------------
-- Area: Korroloka Tunnel (173)
-----------------------------------
zones = zones or {}

zones[xi.zone.KORROLOKA_TUNNEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7012,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7060,  -- You can't fish here.
        CONQUEST_BASE                 = 7160,  -- Tallying conquest results...
        MINING_IS_POSSIBLE_HERE       = 7319,  -- Mining is possible here if you have <item>.
        ENTERED_SPRING                = 7335,  -- The water in this spring is pleasant and tepid. This looks like a nice place to warm yourself up.
        LEFT_SPRING_EARLY             = 7336,  -- You are not warm enough yet. You will need to spend more time than that in the spring to get your body heated up.
        LEFT_SPRING_CLEAN             = 7337,  -- Your whole body is piping hot, and the smell of the Rafflesia pollen is gone!
        MORION_WORM_1                 = 7340,  -- It appears to be a hole made by some kind of animal. Fragments of iron ore are scattered around the area...
        REGIME_REGISTERED             = 9468,  -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 10520, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 10521, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 10522, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 10523, -- You already possess that temporary item.
        NO_COMBINATION                = 10528, -- You were unable to enter a combination.
        COMMON_SENSE_SURVIVAL         = 10552, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        CARGO_CRAB_COLIN_PH =
        {
            [17486002] = 17485980, -- -30.384 1.000 -33.277
            [17486095] = 17485980, -- -85.000 -0.500 -37.000
        },

        DAME_BLANCHE_PH =
        {
            [17486128] = 17486129, -- -345.369 0.716 119.486
            [17486127] = 17486129, -- -319.266 -0.244 130.650
            [17486126] = 17486129, -- -319.225 -0.146 109.776
            [17486124] = 17486129, -- -296.821 -3.207 131.239
            [17486125] = 17486129, -- -292.487 -5.993 141.408
            [17486119] = 17486129, -- -277.338 -9.352 139.763
            [17486118] = 17486129, -- -276.713 -9.954 135.353
        },

        FALCATUS_ARANEI_PH =
        {
            [17486033] = 17486031, -- -68.852 -5.029 141.069
            [17486032] = 17486031, -- -94.545 -6.095 136.480
            [17486034] = 17486031, -- -79.827 -6.046 133.982
            [17486027] = 17486031, -- -25.445 -6.073 142.192
            [17486028] = 17486031, -- -33.446 -6.038 141.987
        },

        KORROLOKA_LEECH = GetFirstID('Korroloka_Leech'),
        MORION_WORM     = 17486190,
    },
    npc =
    {
        MORION_WORM_QM = 17486216,
        EXCAVATION     = GetTableOfIDs('Excavation_Point'),
    },
}

return zones[xi.zone.KORROLOKA_TUNNEL]
