-----------------------------------
-- Area: Giddeus
-----------------------------------
zones = zones or {}

zones[xi.zone.GIDDEUS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7219, -- You can't fish here.
        OFFERED_UP_KEY_ITEM           = 7344, -- Offered up key item: <keyitem>!
        SPRING_FILL_UP                = 7365, -- You fill your flask with water.
        SPRING_DEFAULT                = 7366, -- Sparkling clear water bubbles up from the ground. If you have a container, you can fill it here.
        CHEST_UNLOCKED                = 7416, -- You unlock the chest!
        HARVESTING_IS_POSSIBLE_HERE   = 7424, -- Harvesting is possible here if you have <item>.
        HOMEPOINT_SET                 = 7452, -- Home point set!
    },
    mob =
    {
        HOO_MJUU_THE_TORRENT_PH   =
        {
            [17371513] = 17371515, -- -39.073 0.597 -115.279
        },
        JUU_DUZU_THE_WHIRLWIND_PH =
        {
            [17371298] = 17371300, -- 116.667 -3.442 -261.079
            [17371533] = 17371300, -- 85.728 -0.071 -248.141
            [17371291] = 17371300, -- 99.902 -2.725 -213.337
            [17371525] = 17371300, -- 81.263 0.498 -208.812
            [17371529] = 17371300, -- 72.302 0.642 -202.985
            [17371519] = 17371300, -- 20.353 -3.647 -169.309
        },
        VUU_PUQU_THE_BEGUILER_PH  =
        {
            [17371577] = 17371578, -- -23.973 0.459 -399.155
        },
        VAA_HUJA_THE_ERUDITE      = 17371579,
    },
    npc =
    {
        TREASURE_CHEST = 17371611,
        HARVESTING     = GetTableOfIDs('Harvesting_Point'),
    },
}

return zones[xi.zone.GIDDEUS]
