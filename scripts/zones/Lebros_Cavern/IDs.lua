-----------------------------------
-- Area: Lebros_Cavern
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.LEBROS_CAVERN] =
{
    text = {
        ITEM_CANNOT_BE_OBTAINED    = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6387, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6389, -- Obtained: <item>.
        GIL_OBTAINED               = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6392, -- Obtained key item: <keyitem>.
        KEYITEM_LOST               = 6393, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL        = 6394, -- You do not have enough gil.
        ITEMS_OBTAINED             = 6398, -- You obtain <number> <item>!
        MINE_COUNTDOWN             = 6981, -- <number>...
        CARRIED_OVER_POINTS        = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        TEMP_ITEM                  = 7211, -- Obtained temporary item: <item>!
        ASSAULT_21_START           = 7368, -- Commencing <assault>! Objective: Remove the obstructions
        ASSAULT_22_START           = 7369, -- Commencing <assault>! Objective: Deliver the provisions
        ASSAULT_23_START           = 7370, -- Commencing <assault>! Objective: Destroy the Troll fugitives
        ASSAULT_24_START           = 7371, -- Commencing <assault>! Objective: Discover alternate route
        ASSAULT_25_START           = 7372, -- Commencing <assault>! Objective: Assassinate Borgerlur
        ASSAULT_26_START           = 7373, -- Commencing <assault>! Objective: Match the Apkallu
        ASSAULT_27_START           = 7374, -- Commencing <assault>! Objective: Remove the threat
        ASSAULT_28_START           = 7375, -- Commencing <assault>! Objective: Drive out the hunters
        ASSAULT_29_START           = 7376, -- Commencing <assault>! Objective: Rescue Princess Kadjaya
        ASSAULT_30_START           = 7377, -- Commencing <assault>! Objective: Defeat Black Shuck
        TIME_TO_COMPLETE           = 7408, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED             = 7409, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED              = 7410, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        ASSAULT_POINTS_OBTAINED    = 7412, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES     = 7413, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS     = 7414, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN               = 7416, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
    },

    mob = {
        [EXCAVATION_DUTY] =
        {
            MOBS_START =
            {
                17035265, 17035266, 17035267, 17035268, 17035269, 17035270, 17035271, 17035272, 17035273,
                17035274, 17035275, 17035276, 17035277, 17035278, 17035279, 17035280, 17035281,
                BRITTLE_ROCK1 = 17035283, BRITTLE_ROCK2 = 17035285, BRITTLE_ROCK3 = 17035287, BRITTLE_ROCK4 = 17035289, BRITTLE_ROCK5 = 17035291,
            },
        },

        [LEBROS_SUPPLIES] =
        {
            MOBS_START =
            {
                17035292, 17035293, 17035294, 17035295, 17035296, 17035297, 17035298, 17035299, 17035300, 17035301,
                17035302, 17035303, 17035304, 17035305, 17035306, 17035307, 17035308, 17035309,
            }
        },

        [TROLL_FUGITIVES] =
        {
            MOBS_START =
            {
                17035310, 17035311, 17035312, 17035313, 17035314, 17035315, 17035316, 17035317,
                17035318, 17035319, 17035320, 17035321, 17035322, 17035323, 17035324,
            },
        },

        [WAMOURA_FARM_RAID] =
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
        ANCIENT_LOCKBOX = 17035478,
        RUNE_OF_RELEASE = 17035479,
        _1r8            = 17035512,
        _1rd            = 17035517,
        _1rg            = 17035520,
        _1rm            = 17035526,
        _1rn            = 17035527,
        _1rx            = 17035537,
        _1ry            = 17035538,
        _1rz            = 17035539,
        _ir0            = 17035540,
        _ir1            = 17035541,
        _irc            = 17035552,
        _ire            = 17035554,
        QIQIRN_MINE1    = 17037312,
        QIQIRN_MINE2    = 17037313,
        QIQIRN_MINE3    = 17037314,
        QIQIRN_MINE4    = 17037315,
    }
}

return zones[xi.zone.LEBROS_CAVERN]
