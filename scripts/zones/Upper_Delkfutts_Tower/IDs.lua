-----------------------------------
-- Area: Upper_Delkfutts_Tower
-----------------------------------
zones = zones or {}

zones[xi.zone.UPPER_DELKFUTTS_TOWER] =
{
    text =
    {
        THIS_ELEVATOR_GOES_DOWN       = 25,    -- This elevator goes down, but it is locked. Perhaps a key is needed to activate it.
        ITEM_CANNOT_BE_OBTAINED       = 6419,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6425,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6426,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6428,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6454,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7036,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7037,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7038,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7058,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7096,  -- You can't fish here.
        CONQUEST_BASE                 = 7196,  -- Tallying conquest results...
        CHEST_UNLOCKED                = 7363,  -- You unlock the chest!
        PLAYER_OBTAINS_ITEM           = 7386,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7387,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7388,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7389,  -- You already possess that temporary item.
        NO_COMBINATION                = 7394,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9472,  -- New training regime registered!
        LEARNS_SPELL                  = 10520, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 10522, -- You are assaulted by an uncanny sensation.
        HOMEPOINT_SET                 = 10531, -- Home point set!
    },
    mob =
    {
        ENKELADOS_PH =
        {
            [17424388] = 17424385, -- -371.586 -144.367 28.244
            [17424426] = 17424423, -- -215.194 -144.099 19.528
        },
        IXTAB_PH =
        {
            [17424472] = 17424475,
            [17424473] = 17424475,
            [17424474] = 17424475,
            [17424509] = 17424512,
            [17424510] = 17424512,
            [17424511] = 17424512,
        },
        PALLAS       = 17424444,
        ALKYONEUS    = 17424480,
    },
    npc =
    {
        TREASURE_CHEST = 17424564,
    },
}

return zones[xi.zone.UPPER_DELKFUTTS_TOWER]
