-----------------------------------
-- Area: VeLugannon_Palace
-----------------------------------
zones = zones or {}

zones[xi.zone.VELUGANNON_PALACE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060,  -- Tallying conquest results...
        CHEST_UNLOCKED                = 7227,  -- You unlock the chest!
        EVIL_PRESENCE                 = 7237,  -- You sense an evil presence lurking in the shadows...
        KNIFE_CHANGES_SHAPE           = 7244,  -- The <item> begins to change shape.
        NOTHING_HAPPENS               = 7245,  -- Nothing happens.
        REGIME_REGISTERED             = 10170, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11222, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11223, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11224, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11225, -- You already possess that temporary item.
        NO_COMBINATION                = 11230, -- You were unable to enter a combination.
    },
    mob =
    {
        MIMIC                   = 17502567,
        BRIGANDISH_BLADE        = 17502568,
        STEAM_CLEANER           = 17502569,
        STEAM_CLEANER_DETECTORS =
        {
            -- E Lower Chamber
            17502543,
            17502545,
            -- W Lower Chamber
            17502547,
            17502549,
            -- NE Lower Chamber
            17502551,
            17502553,
            -- NW Lower Chamber
            17502555,
            17502557,
        },
    },
    npc =
    {
        QM3             = 17502583,
        Y_DOOR_OFFSET   = 17502608,
        B_DOOR_OFFSET   = 17502616,
        Y_LITH_OFFSET   = 17502624,
        B_LITH_OFFSET   = 17502634,
        TREASURE_COFFER = 17502699,
    },
}

return zones[xi.zone.VELUGANNON_PALACE]
