-----------------------------------
-- Area: Lebros_Cavern
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.LEBROS_CAVERN] =
{
    text = {
        ITEM_CANNOT_BE_OBTAINED    = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6386, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6388, -- Obtained: <item>.
        GIL_OBTAINED               = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST               = 6392, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL        = 6393, -- You do not have enough gil.
        ITEMS_OBTAINED             = 6397, -- You obtain <number> <item>!
        MINE_COUNTDOWN             = 6980, -- <number>...
        CARRIED_OVER_POINTS        = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY    = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER               = 7001, -- In celebration of your most recent login no. <number>...
        TEMP_ITEM                  = 7210, -- Obtained temporary item: <item>!
        ASSAULT_21_START           = 7367, -- Commencing <assault>! Objective: Remove the obstructions
        ASSAULT_22_START           = 7368, -- Commencing <assault>! Objective: Deliver the provisions
        ASSAULT_23_START           = 7369, -- Commencing <assault>! Objective: Destroy the Troll fugitives
        ASSAULT_24_START           = 7370, -- Commencing <assault>! Objective: Discover alternate route
        ASSAULT_25_START           = 7371, -- Commencing <assault>! Objective: Assassinate Borgerlur
        ASSAULT_26_START           = 7372, -- Commencing <assault>! Objective: Match the Apkallu
        ASSAULT_27_START           = 7373, -- Commencing <assault>! Objective: Remove the threat
        ASSAULT_28_START           = 7374, -- Commencing <assault>! Objective: Drive out the hunters
        ASSAULT_29_START           = 7375, -- Commencing <assault>! Objective: Rescue Princess Kadjaya
        ASSAULT_30_START           = 7376, -- Commencing <assault>! Objective: Defeat Black Shuck
        TIME_TO_COMPLETE           = 7407, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED             = 7408, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED              = 7409, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        ASSAULT_POINTS_OBTAINED    = 7411, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES     = 7412, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS     = 7413, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN               = 7415, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
    },

    mob = {
        -- Escavation Duty
        [21] =
        {
            VOLCANIC_BOMB1   = 17035265,
            VOLCANIC_BOMB2   = 17035266,
            VOLCANIC_BOMB3   = 17035267,
            QIQIRN_CERAMIST1 = 17035268,
            QIQIRN_VOLCANIS1 = 17035269,
            VOLCANIC_BOMB4   = 17035270,
            VOLCANIC_BOMB5   = 17035271,
            VOLCANIC_BOMB6   = 17035272,
            QIQIRN_CERAMIST2 = 17035273,
            QIQIRN_VOLCANIS2 = 17035274,
            QIQIRN_VOLCANIS3 = 17035275,
            QIQIRN_CERAMIST3 = 17035276,
            QIQIRN_CERAMIST4 = 17035277,
            QIQIRN_CERAMIST5 = 17035278,
            QIQIRN_VOLCANIS4 = 17035279,
            VOLCANIC_BOMB7   = 17035280,
            VOLCANIC_BOMB8   = 17035281,
            BRITTLE_ROCK1    = 17035282,
            BRITTLE_ROCK2    = 17035284,
            BRITTLE_ROCK3    = 17035286,
            BRITTLE_ROCK4    = 17035288,
            BRITTLE_ROCK5    = 17035290,
        },
        -- Lebros Suplies
        [22] =
        {
        },
        -- Troll Figitives
        [23] =
        {
            TROLL_FUGITIVE1  = 17035310,
            TROLL_FUGITIVE2  = 17035311,
            TROLL_FUGITIVE3  = 17035312,
            TROLL_FUGITIVE4  = 17035313,
            TROLL_FUGITIVE5  = 17035314,
            TROLL_FUGITIVE6  = 17035315,
            TROLL_FUGITIVE7  = 17035316,
            TROLL_FUGITIVE8  = 17035317,
            TROLL_FUGITIVE9  = 17035318,
            TROLL_FUGITIVE10 = 17035319,
            TROLL_FUGITIVE11 = 17035320,
            TROLL_FUGITIVE12 = 17035321,
            TROLL_FUGITIVE13 = 17035322,
            TROLL_FUGITIVE14 = 17035323,
            TROLL_FUGITIVE15 = 17035324,

        },
        -- Evade and Escape
        [24] =
        {
        },
        -- Siegemaster Assassination
        [25] =
        {
        },
        -- Apkallu Breeding
        [26] =
        {
        },
        -- Wamoura Farm Raid Assault
        [27] =
        {
            RANCH_WAMOURA1  = 17035359,
            RANCH_WAMOURA2  = 17035360,
            RANCH_WAMOURA3  = 17035361,
            RANCH_WAMOURA4  = 17035362,
            RANCH_WAMOURA5  = 17035363,
            RANCH_WAMOURA6  = 17035365,
            RANCH_WAMOURA7  = 17035367,
            RANCH_WAMOURA8  = 17035368,
            RANCH_WAMOURA9  = 17035369,
            RANCH_WAMOURA10 = 17035370,
            RANCH_WAMOURA11 = 17035371,
            RANCH_WAMOURA12 = 17035372,
            RANCH_WAMOURA13 = 17035376,
            RANCH_WAMOURA14 = 17035377,
            RANCH_WAMOURA15 = 17035378,
        },
        -- Egg Conservation
        [28] =
        {
        },
        -- Operation Black Pearl
        [29] =
        {
        },
        -- Better Than One
        [30] =
        {
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
        _jr0            = 17035540,
        _jr1            = 17035541,
        _jrc            = 17035552,
        _jre            = 17035554,
        QIQIRN_MINE1    = 17037312,
        QIQIRN_MINE2    = 17037313,
        QIQIRN_MINE3    = 17037314,
        QIQIRN_MINE4    = 17037315,
    }
}

return zones[tpz.zone.LEBROS_CAVERN]
