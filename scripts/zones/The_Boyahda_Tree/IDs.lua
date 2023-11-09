-----------------------------------
-- Area: The_Boyahda_Tree
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_BOYAHDA_TREE] =
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
        FISHING_MESSAGE_OFFSET        = 7061,  -- You can't fish here.
        CHEST_UNLOCKED                = 7169,  -- You unlock the chest!
        CAN_SEE_SKY                   = 7182,  -- You can see the sky from here.
        SOMETHING_NOT_RIGHT           = 7183,  -- Something is not right!
        CANNOT_SEE_MOON               = 7184,  -- You cannot see the moon right now.
        CONQUEST_BASE                 = 7185,  -- Tallying conquest results...
        WARDEN_SPEECH                 = 7344,  -- Pi...!
        WARDEN_TRANSLATION            = 7345,  -- The warden appears to want something from you...
        SENSE_OMINOUS_PRESENCE        = 7405,  -- You sense an ominous presence...
        REGIME_REGISTERED             = 10348, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11400, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11401, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11402, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11403, -- You already possess that temporary item.
        NO_COMBINATION                = 11408, -- You were unable to enter a combination.
        HOMEPOINT_SET                 = 11446, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 11504, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        ELLYLLON_PH          =
        {
            [17403938] = 17403939, -- 192.54 8.532 -163.41
        },
        AQUARIUS_PH          =
        {
            [17403993] = 17404000, -- 170.97 9.414 -12.579
            [17403994] = 17404000, -- 174.99 9.589 -16.718
            [17403995] = 17404000, -- 182.40 8.707 -33.993
            [17403997] = 17404000, -- 163.31 9.590 -58.550
            [17403998] = 17404000, -- 162.88 9.591 -58.082
            [17403999] = 17404000, -- 195.37 8.972 -73.536
            [17404002] = 17404000, -- 149.30 9.742 -64.239
            [17404003] = 17404000, -- 146.14 9.712 -51.616
            [17404004] = 17404000, -- 149.59 9.765 -61.490
        },
        UNUT_PH              =
        {
            [17404014] = 17404029, -- 112.08 8.368 34.423
            [17404015] = 17404029, -- 134.44 7.846 45.197
            [17404016] = 17404029, -- 127.32 7.768 93.138
            [17404018] = 17404029, -- 95.055 8.132 71.958
            [17404019] = 17404029, -- 108.66 8.193 49.643
            [17404020] = 17404029, -- 97.774 7.837 67.815
            [17404025] = 17404029, -- 109.55 8.561 83.275
            [17404026] = 17404029, -- 59.283 8.700 78.246
            [17404027] = 17404029, -- 60.408 8.711 82.500
            [17404030] = 17404029, -- 70.822 6.211 61.711
            [17404031] = 17404029, -- 57.942 8.544 88.215
            [17404032] = 17404029, -- 66.392 5.884 66.909
        },
        LESHONKI_PH =
        {
            [17404293] = 17404300, -- -222.0 14.380 25.724
            [17404294] = 17404300, -- -223.5 14.430 23.877
            [17404295] = 17404300, -- -215.2 13.585 68.666
            [17404296] = 17404300, -- -216.4 14.317 56.532
            [17404302] = 17404300, -- -223.8 14.267 96.920
        },
        VOLUPTUOUS_VIVIAN_PH =
        {
            [17404330] = 17404331, -- -196.178 5.592 190.971
        },
        MIMIC                = 17404336,
        AGAS                 = 17404337,
        BEET_LEAFHOPPER      = 17404338,
    },
    npc =
    {
        TREASURE_COFFER = 17404395,
    },
}

return zones[xi.zone.THE_BOYAHDA_TREE]
