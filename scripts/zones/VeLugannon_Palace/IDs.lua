-----------------------------------
-- Area: VeLugannon_Palace
-----------------------------------
zones = zones or {}

zones[xi.zone.VELUGANNON_PALACE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068,  -- Tallying conquest results...
        CHEST_UNLOCKED                = 7235,  -- You unlock the chest!
        EVIL_PRESENCE                 = 7245,  -- You sense an evil presence lurking in the shadows...
        KNIFE_CHANGES_SHAPE           = 7252,  -- The <item> begins to change shape.
        NOTHING_HAPPENS               = 7253,  -- Nothing happens.
        REGIME_REGISTERED             = 10178, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11230, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11231, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11232, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11233, -- You already possess that temporary item.
        NO_COMBINATION                = 11238, -- You were unable to enter a combination.
    },
    mob =
    {
        BRIGANDISH_BLADE = GetFirstID('Brigandish_Blade'),
        DETECTOR         = GetTableOfIDs('Detector'),
        MIMIC            = GetFirstID('Mimic'),
        STEAM_CLEANER    = GetFirstID('Steam_Cleaner'),
        ZIPACNA          = GetFirstID('Zipacna'),
    },
    npc =
    {
        QM3             = GetFirstID('qm3'),
        Y_DOOR_OFFSET   = GetFirstID('_4x0'),
        B_DOOR_OFFSET   = GetFirstID('_4x8'),
        Y_LITH_OFFSET   = GetTableOfIDs('Monolith')[1],
        B_LITH_OFFSET   = GetTableOfIDs('Monolith')[6],
        TREASURE_COFFER = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.VELUGANNON_PALACE]
