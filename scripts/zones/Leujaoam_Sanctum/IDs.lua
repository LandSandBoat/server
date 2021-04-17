-----------------------------------
-- Area: Leujaoam_Sanctum
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.LEUJAOAM_SANCTUM] =
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
        CARRIED_OVER_POINTS        = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        ASSAULT_01_START           = 7448, -- Commencing <assault>! Objective: Remove all threats
        ASSAULT_02_START           = 7449, -- Commencing <assault>! Objective: Discover orichalcum ore
        ASSAULT_03_START           = 7450, -- Commencing <assault>! Objective: Protect the professor
        ASSAULT_04_START           = 7451, -- Commencing <assault>! Objective: Protect the vegetation
        ASSAULT_05_START           = 7452, -- Commencing <assault>! Objective: Buy black sheep
        ASSAULT_06_START           = 7453, -- Commencing <assault>! Objective: Retrieve the supplies
        ASSAULT_07_START           = 7454, -- Commencing <assault>! Objective: Become a test subject
        ASSAULT_08_START           = 7455, -- Commencing <assault>! Objective: Retrieve the OGMA
        ASSAULT_09_START           = 7456, -- Commencing <assault>! Objective: Defeat Raubahn
        ASSAULT_10_START           = 7457, -- Commencing <assault>! Objective: Defeat the count
        TIME_TO_COMPLETE           = 7508, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED             = 7509, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS          = 7510, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        RUNE_UNLOCKED              = 7511, -- ission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED    = 7512, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES     = 7513, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS     = 7514, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN               = 7516, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
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
        _1X1            = 17060120,
        _1X2            = 17060121,
        _1X3            = 17060122,
        _1X4            = 17060123,
        _1X5            = 17060124,
        _1X6            = 17060125,
        _1X7            = 17060126,
        _1X8            = 17060127,
        _1X9            = 17060128,
        _1XA            = 17060129,
        _1XB            = 17060130,
        _1XC            = 17060131,
        _1XD            = 17060132,
        _1XE            = 17060133,
        _1XF            = 17060134,
        _1XG            = 17060135,
        _1XH            = 17060136,
        _1XI            = 17060137,
        _1XJ            = 17060138,
        _1XK            = 17060139,
        _1XL            = 17060140,
        _1XM            = 17060141,
        _1XN            = 17060142,
        _1XO            = 17060143,
        _1XP            = 17060144,
        _1XQ            = 17060145,
        _1XR            = 17060146,
        _1XS            = 17060147,
        _1XT            = 17060148,
        _1XU            = 17060149,
        _1XV            = 17060150,
        _1XW            = 17060151,
        _1XX            = 17060152,
        _1XY            = 17060153,
        _1XZ            = 17060154,
        _JX0            = 17060155,
        _JX1            = 17060156,
        _JX2            = 17060157,
        _JX3            = 17060158,
        _JX4            = 17060159,
        _JX5            = 17060160,
        _JX6            = 17060161,
        _JX7            = 17060162,
        _JX8            = 17060163,
        _JX9            = 17060164,
        _JXA            = 17060165,
        _JXB            = 17060166,
        _JXC            = 17060167,
        _JXD            = 17060168,
        _JXE            = 17060169,
        _JXF            = 17060170,
        _JXG            = 17060171,
        _JXH            = 17060172,
        _JXI            = 17060173,
        _JXJ            = 17060174,
        _JXK            = 17060175,
    }
}

return zones[xi.zone.LEUJAOAM_SANCTUM]
