-----------------------------------
-- Area: The_Shrine_of_RuAvitau
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_SHRINE_OF_RUAVITAU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7072,  -- You can't fish here.
        CONQUEST_BASE                 = 7173,  -- Tallying conquest results...
        SMALL_HOLE_HERE               = 7360,  -- There is a small hole here. It appears to be damp inside...
        KIRIN_OFFSET                  = 7371,  -- I am Kirin, master of the Shijin. The one who stands above all. You, who have risen above your mortal status to contend with the gods... It is time to reap your reward.
        REGIME_REGISTERED             = 10363, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11415, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11416, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11417, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11418, -- You already possess that temporary item.
        NO_COMBINATION                = 11423, -- You were unable to enter a combination.
        HOMEPOINT_SET                 = 11449, -- Home point set!
    },
    mob =
    {
        ULLIKUMMI       = GetFirstID('Ullikummi'),
        OLLAS_OFFSET    = GetFirstID('Olla_Pequena'),
        KIRIN           = GetFirstID('Kirin'),
        MOTHER_GLOBE    = GetFirstID('Mother_Globe'),
    },
    npc =
    {
        OLLAS_QM        = GetFirstID('qm1'),
        KIRIN_QM        = GetFirstID('qm2'),
        DOOR_OFFSET     = GetFirstID('_4y0'),
        MONOLITH_OFFSET = GetFirstID('Monolith'),
    },
}

return zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
