-----------------------------------
-- Area: Leujaoam_Sanctum
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.LEUJAOAM_SANCTUM] =
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
        CARRIED_OVER_POINTS        = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        ASSAULT_01_START           = 7447, -- Commencing <assault>! Objective: Remove all threats
        ASSAULT_02_START           = 7448, -- Commencing <assault>! Objective: Discover orichalcum ore
        ASSAULT_03_START           = 7449, -- Commencing <assault>! Objective: Protect the professor
        ASSAULT_04_START           = 7450, -- Commencing <assault>! Objective: Protect the vegetation
        ASSAULT_05_START           = 7451, -- Commencing <assault>! Objective: Buy black sheep
        ASSAULT_06_START           = 7452, -- Commencing <assault>! Objective: Retrieve the supplies
        ASSAULT_07_START           = 7453, -- Commencing <assault>! Objective: Become a test subject
        ASSAULT_08_START           = 7454, -- Commencing <assault>! Objective: Retrieve the OGMA
        ASSAULT_09_START           = 7455, -- Commencing <assault>! Objective: Defeat Raubahn
        ASSAULT_10_START           = 7456, -- Commencing <assault>! Objective: Defeat the count
        TIME_TO_COMPLETE           = 7507, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED             = 7508, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS          = 7509, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        RUNE_UNLOCKED              = 7510, -- ission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED    = 7511, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES     = 7512, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS     = 7513, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN               = 7515, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
    },

    mob =
    {
        -- Leujaoam Cleansing
        [1] =
        {
            LEUJAOAM_WORM1  = 17059841,
            LEUJAOAM_WORM2  = 17059842,
            LEUJAOAM_WORM3  = 17059843,
            LEUJAOAM_WORM4  = 17059844,
            LEUJAOAM_WORM5  = 17059845,
            LEUJAOAM_WORM6  = 17059846,
            LEUJAOAM_WORM7  = 17059847,
            LEUJAOAM_WORM8  = 17059848,
            LEUJAOAM_WORM9  = 17059849,
            LEUJAOAM_WORM10 = 17059850,
            LEUJAOAM_WORM11 = 17059851,
            LEUJAOAM_WORM12 = 17059852,
            LEUJAOAM_WORM13 = 17059853,
            LEUJAOAM_WORM14 = 17059854,
            LEUJAOAM_WORM15 = 17059855,
        }
    },

    npc =
    {
        ANCIENT_LOCKBOX = 17060014,
        RUNE_OF_RELEASE = 17060015,
        _1X1            = 17060116,
        _1X2            = 17060117,
        _1X3            = 17060118,
        _1X4            = 17060119,
        _1X5            = 17060120,
        _1X6            = 17060121,
        _1X7            = 17060122,
        _1X8            = 17060123,
        _1X9            = 17060124,
        _1XA            = 17060125,
        _1XB            = 17060126,
        _1XC            = 17060127,
        _1XD            = 17060128,
        _1XE            = 17060129,
        _1XF            = 17060130,
        _1XG            = 17060131,
        _1XH            = 17060132,
        _1XI            = 17060133,
        _1XJ            = 17060134,
        _1XK            = 17060135,
        _1XL            = 17060136,
        _1XM            = 17060137,
        _1XN            = 17060138,
        _1XO            = 17060139,
        _1XP            = 17060140,
        _1XQ            = 17060141,
        _1XR            = 17060142,
        _1XS            = 17060143,
        _1XT            = 17060144,
        _1XU            = 17060145,
        _1XV            = 17060146,
        _1XW            = 17060147,
        _1XX            = 17060148,
        _1XY            = 17060149,
        _1XZ            = 17060150,
        _JX0            = 17060151,
        _JX1            = 17060152,
        _JX2            = 17060153,
        _JX3            = 17060154,
        _JX4            = 17060155,
        _JX5            = 17060156,
        _JX6            = 17060157,
        _JX7            = 17060158,
        _JX8            = 17060159,
        _JX9            = 17060160,
        _JXA            = 17060161,
        _JXB            = 17060162,
        _JXC            = 17060163,
        _JXD            = 17060164,
        _JXE            = 17060165,
        _JXF            = 17060166,
        _JXG            = 17060167,
        _JXH            = 17060168,
        _JXI            = 17060169,
        _JXJ            = 17060170,
        _JXK            = 17060171,
    }
}

return zones[tpz.zone.LEUJAOAM_SANCTUM]
