-----------------------------------
-- Area: The_Shrine_of_RuAvitau
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_SHRINE_OF_RUAVITAU] =
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
        FISHING_MESSAGE_OFFSET        = 7061,  -- You can't fish here.
        CONQUEST_BASE                 = 7161,  -- Tallying conquest results...
        SMALL_HOLE_HERE               = 7348,  -- There is a small hole here. It appears to be damp inside...
        KIRIN_OFFSET                  = 7359,  -- I am Kirin, master of the Shijin. The one who stands above all. You, who have risen above your mortal status to contend with the gods... It is time to reap your reward.
        REGIME_REGISTERED             = 10351, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11403, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11404, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11405, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11406, -- You already possess that temporary item.
        NO_COMBINATION                = 11411, -- You were unable to enter a combination.
        HOMEPOINT_SET                 = 11437, -- Home point set!
    },
    mob =
    {
        ULLIKUMMI        = 17506418,
        OLLAS_OFFSET     = 17506667,
        KIRIN            = 17506670,
        MOTHER_GLOBE     = 17506396,
    },
    npc =
    {
        DOORS =
        {
            [ 0] = 'y', [ 4] = 'b',
            [ 1] = 'y', [ 5] = 'b',
            [ 2] = 'y', [ 6] = 'b',
            [ 3] = 'y', [ 7] = 'b',
            [ 8] = 'y', [ 9] = 'b',
            [12] = 'y', [10] = 'b',
            [13] = 'y', [11] = 'b',
            [14] = 'y', [16] = 'b',
            [15] = 'y', [17] = 'b',
            [19] = 'y', [18] = 'b',
            [21] = 'y', [20] = 'b',
        },
        MONOLITHS =
        {
            [ 0] = 'y', [ 4] = 'b',
            [ 1] = 'y', [ 5] = 'b',
            [ 2] = 'y', [ 6] = 'b',
            [ 3] = 'y', [ 7] = 'b',
            [ 9] = 'y', [ 8] = 'b',
            [12] = 'y', [10] = 'b',
            [13] = 'y', [11] = 'b',
            [16] = 'y', [14] = 'b',
            [17] = 'y', [15] = 'b',
            [18] = 'y', [19] = 'b',
        },
        OLLAS_QM        = 17506692,
        DOOR_OFFSET     = 17506718,
        MONOLITH_OFFSET = 17506741,
    },
}

return zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
