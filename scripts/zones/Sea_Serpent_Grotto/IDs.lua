-----------------------------------
-- Area: Sea_Serpent_Grotto
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SEA_SERPENT_GROTTO] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6386,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6388,  -- Obtained: <item>.
        GIL_OBTAINED               = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6391,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED             = 6397,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY    = 6402,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET      = 6417,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS        = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE              = 7049,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET     = 7208,  -- You can't fish here.
        CHEST_UNLOCKED             = 7316,  -- You unlock the chest!
        SAHAGIN_DOOR_INSIDE        = 7334,  -- The door is tightly shut.
        SAHAGIN_DOOR_OUTSIDE       = 7335,  -- This door has an oddly shaped keyhole. It looks as if once you enter, you may not be able to get out the way you came in.
        SAHAGIN_DOOR_TRADED        = 7336,  -- The <item> breaks!
        FIRST_CHECK                = 7340,  -- You do not see anything out of the ordinary.
        SECOND_CHECK               = 7341,  -- You do not see anything out of the ordinary...
        THIRD_CHECK                = 7342,  -- It looks like a rock wall.
        FOURTH_CHECK               = 7343,  -- It looks like a rock wall...
        FIFTH_CHECK                = 7344,  -- You see a small indentation in the wall.
        SILVER_CHECK               = 7345,  -- You see something silver glittering around the indentation.
        MYTHRIL_CHECK              = 7346,  -- You find something that looks like mythril dust scattered about the indentation.
        GOLD_CHECK                 = 7347,  -- You see something gold glittering around the indentation.
        COMPLETED_CHECK            = 7348,  -- It is a door you can open using <item>!
        SENSE_OMINOUS_PRESENCE     = 7362,  -- You sense an ominous presence...
        PLAYER_OBTAINS_ITEM        = 7596,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM      = 7597,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM   = 7598,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP       = 7599,  -- You already possess that temporary item.
        NO_COMBINATION             = 7604,  -- You were unable to enter a combination.
        REGIME_REGISTERED          = 9682,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL      = 10742, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        MASAN_PH =
        {
            [17498155] = 17498159, -- 17.001 9.340 186.571
            [17498156] = 17498159, -- 18.702 9.512 183.594
        },
        NAMTAR_PH =
        {
            [17498178] = 17498184, -- -128.762 9.595 164.996
            [17498183] = 17498184, -- -157.606 9.905 168.518
        },
        WUUR_THE_SANDCOMBER_PH =
        {
            [17498195] = 17498199, -- 14.044 0.494 109.487
        },
        FYUU_THE_SEABELLOW_PH =
        {
            [17498266] = 17498269, -- 185.074 20.252 39.317
        },
        QULL_THE_SHELLBUSTER_PH =
        {
            [17498280] = 17498285, -- 348.293 10.133 -65.543
            [17498283] = 17498285, -- 363.430 10.578 -62.752
        },
        SEWW_THE_SQUIDLIMBED_PH =
        {
            [17498298] = 17498301, -- 232.828 9.860 63.214
        },
        PAHH_THE_GULLCALLER_PH =
        {
            [17498336] = 17498341, -- -13.532 21.301 -20.861
        },
        MOUU_THE_WAVERIDER_PH =
        {
            [17498355] = 17498356, -- -60.728 19.884 53.966
        },
        WORR_THE_CLAWFISTED_PH =
        {
            [17498410] = 17498413, -- -308.649 17.344 -52.316
        },
        SEA_HOG_PH =
        {
            [17498418] = 17498420, -- -221.455 9.542 -44.191
            [17498419] = 17498420, -- -249 10 -57
        },
        VOLL_THE_SHARKFINNED_PH =
        {
            [17498426] = 17498428, -- -337.035 16.950 -106.841
        },
        YARR_THE_PEARLEYED_PH =
        {
            [17498434] = 17498436, -- 1.654 19.914 -113.913
        },
        NOVV_THE_WHITEHEARTED_PH =
        {
            [17498444] = 17498445,
        },
        DENN_THE_ORCAVOICED_PH =
        {
            [17498461] = 17498464, -- -102.127 9.797 -308.149
        },
        ZUUG_THE_SHORELEAPER_PH =
        {
            [17498512] = 17498516,
        },
        CHARYBDIS_PH =
        {
            [17498518] = 17498522, -- -138.181, 48.389, -338.001
            [17498520] = 17498522, -- -212.407, 38.538, -342.544
        },
        MIMIC        = 17498564,
        WATER_LEAPER = 17498565,
    },
    npc =
    {
        CASKET_BASE     = 17498579,
        TREASURE_CHEST  = 17498625,
        TREASURE_COFFER = 17498626,
    },
}

return zones[tpz.zone.SEA_SERPENT_GROTTO]
