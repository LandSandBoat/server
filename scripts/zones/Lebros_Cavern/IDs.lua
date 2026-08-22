-----------------------------------
-- Area: Lebros_Cavern
-----------------------------------
zones = zones or {}

zones[xi.zone.LEBROS_CAVERN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6391, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6400, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6404, -- You obtain <number> <item>!
        MINE_COUNTDOWN                = 6987, -- <number>...
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        TEMP_ITEM                     = 7230, -- Obtained temporary item: <item>!
        PLAYER_OBTAINS_ITEM           = 7231, -- <name> obtains <item>!
        ASSAULT_START_OFFSET          = 7366, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE              = 7427, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7428, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7429, -- Mission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-<number>).
        ASSAULT_POINTS_OBTAINED       = 7431, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7432, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7433, -- Time remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7435, -- All party members have fallen in battle. Mission failure in <number> [minute/minutes].
    },

    mob =
    {
        VOLCANIC_BOMB  = GetFirstID('Volcanic_Bomb'),
        WAMOURA_OFFSET = GetTableOfIDs('Ranch_Wamoura'),
        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            MOBS_START =
            {
                17035292, 17035293, 17035294, 17035295, 17035296, 17035297, 17035298, 17035299, 17035300, 17035301,
                17035302, 17035303, 17035304, 17035305, 17035306, 17035307, 17035308, 17035309,
            }
        },
        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            MOBS_START =
            {
                17035310, 17035311, 17035312, 17035313, 17035314, 17035315, 17035316, 17035317,
                17035318, 17035319, 17035320, 17035321, 17035322, 17035323, 17035324,
            },
        },
        [xi.assault.mission.WAMOURA_FARM_RAID] =
        {
            MOBS_START =
            {
                17035359, 17035360, 17035361, 17035362, 17035363, 17035364, 17035365, 17035366, 17035367, 17035368,
                17035369, 17035370, 17035371, 17035372, 17035373, 17035374, 17035375, 17035376, 17035377, 17035378,
            },
        }
    },

    npc =
    {
        ANCIENT_LOCKBOX = GetFirstID('Ancient_Lockbox'),
        RUNE_OF_RELEASE = GetFirstID('Rune_of_Release'),
        _1rx            = GetFirstID('_1rx'),
        _1ry            = GetFirstID('_1ry'),
        _1rz            = GetFirstID('_1rz'),
        _jr0            = GetFirstID('_jr0'),
        _jr1            = GetFirstID('_jr1'),
    }
}

return zones[xi.zone.LEBROS_CAVERN]
