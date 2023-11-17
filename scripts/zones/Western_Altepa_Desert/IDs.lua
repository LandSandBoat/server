-----------------------------------
-- Area: Western_Altepa_Desert
-----------------------------------
zones = zones or {}

zones[xi.zone.WESTERN_ALTEPA_DESERT] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6399,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7061,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7220,  -- You can't fish here.
        DIG_THROW_AWAY                = 7233,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7235,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7301,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        THE_DOOR_IS_LOCKED            = 7340,  -- The door is locked.
        DOES_NOT_RESPOND              = 7341,  -- It does not respond.
        CANNOT_REMOVE_FRAG            = 7357,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7358,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS        = 7359,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS               = 7360,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7361,  -- It is an ancient Zilart monument.
        FEEL_SOMETHING_PRICKLY        = 7379,  -- You feel something prickly...
        MANY_STONES_LITTER_AREA       = 7380,  -- Many stones litter the area.
        EVIL_LOOMING_ABOVE_YOU        = 7381,  -- You sense something evil looming above you.
        SENSE_OMINOUS_PRESENCE        = 7401,  -- You sense an ominous presence...
        SOMETHING_IS_BURIED_HERE      = 7419,  -- It looks like something is buried here. If you had <item> you could dig it up.
        PLAYER_OBTAINS_ITEM           = 7639,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7640,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7641,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7642,  -- You already possess that temporary item.
        NO_COMBINATION                = 7647,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7709,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9825,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11814, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        PICOLATON_PH =
        {
            [17289637] = 17289638,
        },

        CACTUAR_CANTAUTOR_PH =
        {
            [17289559] = 17289560, -- -458.944 0.018 -557.266
            [17289578] = 17289560, -- -478.142 -0.457 -596.091
        },
        CELPHIE_PH           =
        {
            [17289473] = 17289453, -- 78.226 -0.497 69.745
            [17289450] = 17289453, -- 57.256 0.116 13.972
            [17289451] = 17289453, -- 70.263 0.130 -23.484
            [17289452] = 17289453, -- 50.014 0.256 7.088
            [17289407] = 17289453, -- 10.439 -0.280 -80.476
            [17289406] = 17289453, -- 35.924 0.087 -98.228
            [17289474] = 17289453, -- 118.575 -0.299 127.016
            [17289277] = 17289453, -- 99.000 -0.030 116.000
        },
        CALCHAS_PH =
        {
            [17289545] = 17289547,
            [17289546] = 17289547,
        },
        KING_VINEGARROON     = 17289575,
        SABOTENDER_ENAMORADO = 17289653,
        EASTERN_SPHINX       = 17289654,
        WESTERN_SPHINX       = 17289655,
        MAHARAJA             = 17289656,
    },
    npc =
    {
        ALTEPA_GATE       = 17289747,
        PEDDLESTOX        = 17289772,
        BEASTMEN_TREASURE =
        {
            17289775, -- qm3
            17289776, -- qm4
            17289777, -- qm5
            17289778, -- qm6
            17289779, -- qm7
            17289780, -- qm8
            17289781, -- qm9
            17289782, -- qm10
        },
    },
}

return zones[xi.zone.WESTERN_ALTEPA_DESERT]
