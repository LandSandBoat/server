-----------------------------------
-- Area: Upper_Delkfutts_Tower
-----------------------------------
zones = zones or {}

zones[xi.zone.UPPER_DELKFUTTS_TOWER] =
{
    text =
    {
        THIS_ELEVATOR_GOES_DOWN       = 25,    -- This elevator goes down, but it is locked. Perhaps a key is needed to activate it.
        NOTHING_OUT_OF_ORDINARY       = 6440,  -- There is nothing out of the ordinary here.
        ITEM_CANNOT_BE_OBTAINED       = 6420,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6426,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6427,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6429,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6455,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7037,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7038,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7039,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7059,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7103,  -- You can't fish here.
        CONQUEST_BASE                 = 7203,  -- Tallying conquest results...
        CHEST_UNLOCKED                = 7370,  -- You unlock the chest!
        PLAYER_OBTAINS_ITEM           = 7393,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7394,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7395,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7396,  -- You already possess that temporary item.
        NO_COMBINATION                = 7401,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9479,  -- New training regime registered!
        LEARNS_SPELL                  = 10527, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 10529, -- You are assaulted by an uncanny sensation.
        HOMEPOINT_SET                 = 10538, -- Home point set!
    },
    mob =
    {
        ENKELADOS = GetTableOfIDs('Enkelados'),
        IXTAB     = GetTableOfIDs('Ixtab'),
        PALLAS    = GetFirstID('Pallas'),
        ALKYONEUS = GetFirstID('Alkyoneus'),
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.UPPER_DELKFUTTS_TOWER]
