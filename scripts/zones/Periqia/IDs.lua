-----------------------------------
-- Area: Periqia
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.PERIQIA] =
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
        ASSAULT_31_START           = 7478, -- Commencing <assault>! Objective: Escort the prisoner
        ASSAULT_32_START           = 7479, -- Commencing <assault>! Objective: Destroy the undead
        ASSAULT_33_START           = 7480, -- Commencing <assault>! Objective: Find the survivors
        ASSAULT_34_START           = 7481, -- Commencing <assault>! Objective: Eliminate the Black Baron
        ASSAULT_35_START           = 7482, -- Commencing <assault>! Objective: Activate the bridge
        ASSAULT_36_START           = 7483, -- Commencing <assault>! Objective: Exterminate the chigoes
        ASSAULT_37_START           = 7484, -- Commencing <assault>! Objective: Clear the mine fields
        ASSAULT_38_START           = 7485, -- Commencing <assault>! Objective: Locate the generals
        ASSAULT_39_START           = 7486, -- Commencing <assault>! Objective: Retrieve the Mark-IIs
        ASSAULT_40_START           = 7487, -- Commencing <assault>! Objective: Assassinate King Goldemar
        TIME_TO_COMPLETE           = 7508, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED             = 7509, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS          = 7510, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        RUNE_UNLOCKED              = 7511, -- ission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED    = 7512, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES     = 7513, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS     = 7514, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN               = 7516, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        EXCALIACE_START            = 7525, -- Such a lot of trouble for one little corsair... Shall we be on our way?
        EXCALIACE_END1             = 7526, -- Yeah, I got it. Stay here and keep quiet.
        EXCALIACE_END2             = 7527, -- Hey... It was a short trip, but nothing is ever dull around you, huh?
        EXCALIACE_ESCAPE           = 7528, -- Heh. The Immortals really must be having troubles finding troops if they sent this bunch of slowpokes to watch over me...
        EXCALIACE_PAIN1            = 7529, -- Oomph!
        EXCALIACE_PAIN2            = 7530, -- Ouch!
        EXCALIACE_PAIN3            = 7531, -- Youch!
        EXCALIACE_PAIN4            = 7532, -- Damn, that's gonna leave a mark!
        EXCALIACE_PAIN5            = 7533, -- Urggh!
        EXCALIACE_CRAB1            = 7534, -- Over to you.
        EXCALIACE_CRAB2            = 7535, -- What's this guy up to?
        EXCALIACE_CRAB3            = 7536, -- Uh-oh.
        EXCALIACE_DEBAUCHER1       = 7537, -- Wh-what the...!?
        EXCALIACE_DEBAUCHER2       = 7538, -- H-help!!!
        EXCALIACE_RUN              = 7539, -- Now's my chance!
        EXCALIACE_TOO_CLOSE        = 7540, -- Okay, okay, you got me! I promise I won't run again if you step back a bit...please. Someone's been eating too much garlic...
        EXCALIACE_TIRED            = 7541, -- <Pant>...<wheeze>...
        EXCALIACE_CAUGHT           = 7542, -- Damn...
    },

    mob =
    {
        -- Seagull Grounded
        [31] =
        {
            CRAB1      = 17006594,
            CRAB2      = 17006595,
            CRAB3      = 17006596,
            CRAB4      = 17006597,
            CRAB5      = 17006598,
            CRAB6      = 17006599,
            CRAB7      = 17006600,
            CRAB8      = 17006601,
            CRAB9      = 17006602,
            DEBAUCHER1 = 17006603,
            PUGIL1     = 17006604,
            PUGIL2     = 17006605,
            PUGIL3     = 17006606,
            PUGIL4     = 17006607,
            PUGIL5     = 17006608,
            DEBAUCHER2 = 17006610,
            DEBAUCHER3 = 17006611,
        },
        -- Requiem
        [32] =
        {
            PUTRID_IMMORTAL_GUARD1 = 17006612,
            PUTRID_IMMORTAL_GUARD2 = 17006613,
            BATTEILANT_BHOOT1      = 17006614,
            BATTEILANT_BHOOT2      = 17006615,
            DARKLING_DRAUGAR1      = 17006616,
            DRACONIC_DRAUGAR1      = 17006617,
            DARKLING_DRAUGAR2      = 17006619,
            DARKLING_DRAUGAR3      = 17006620,
            DRACONIC_DRAUGAR2      = 17006621,
            DRACONIC_DRAUGAR3      = 17006623,
            BATTEILANT_BHOOT3      = 17006625,
            BATTEILANT_BHOOT4      = 17006626,
            DARKLING_DRAUGAR4      = 17006627,
            DRACONIC_DRAUGAR4      = 17006628,
            DARKLING_DRAUGAR5      = 17006630,
            DRACONIC_DRAUGAR5      = 17006631,
            DARKLING_DRAUGAR6      = 17006633,
            DARKLING_DRAUGAR7      = 17006634,
        },
        -- Shades of Vengeance
        [79] =
        {
            K23H1LAMIA1  = 17006754,
            K23H1LAMIA2  = 17006755,
            K23H1LAMIA3  = 17006756,
            K23H1LAMIA4  = 17006757,
            K23H1LAMIA5  = 17006758,
            K23H1LAMIA6  = 17006759,
            K23H1LAMIA7  = 17006760,
            K23H1LAMIA8  = 17006761,
            K23H1LAMIA9  = 17006762,
            K23H1LAMIA10 = 17006763,
        }
    },

    npc =
    {
        EXCALIACE       = 17006593,
        ANCIENT_LOCKBOX = 17006809,
        RUNE_OF_RELEASE = 17006810,
        _1K1            = 17006840,
        _1K2            = 17006841,
        _1K3            = 17006842,
        _1K4            = 17006843,
        _1K5            = 17006844,
        _1K6            = 17006845,
        _1K7            = 17006846,
        _1K8            = 17006847,
        _1K9            = 17006848,
        _1KA            = 17006849,
        _1KB            = 17006850,
        _1KC            = 17006851,
        _1KD            = 17006852,
        _1KE            = 17006853,
        _1KF            = 17006854,
        _1KG            = 17006855,
        _1KH            = 17006856,
        _1KI            = 17006857,
        _1KJ            = 17006858,
        _1KK            = 17006859,
        _1KL            = 17006860,
        _1KM            = 17006861,
        _1KN            = 17006862,
        _1KO            = 17006863,
        _1KP            = 17006864,
        _1KQ            = 17006865,
        _1KR            = 17006866,
        _1KS            = 17006867,
        _1KT            = 17006868,
        _1KU            = 17006869,
        _1KV            = 17006870,
        _1KW            = 17006871,
        _1KX            = 17006872,
        _1KY            = 17006873,
        _1KZ            = 17006874,
        _JK0            = 17006875,
        _JK1            = 17006876,
        _JK2            = 17006877,
        _JK3            = 17006878,
        _JK4            = 17006879,
        _JK5            = 17006880,
        _JK6            = 17006881,
        _JK7            = 17006882,
        _JK8            = 17006883,
        _JK9            = 17006884,
        _JKA            = 17006885,
        _JKB            = 17006886,
        _JKC            = 17006887,
        _JKD            = 17006888,
        _JKE            = 17006889,
        _JKF            = 17006890,
        _JKG            = 17006891,
        _JKH            = 17006892,
        _JKI            = 17006893,
        _JKJ            = 17006894,
        _JKK            = 17006895,
        _JKL            = 17006896,
        _JKM            = 17006897,
        _JKN            = 17006898,
        _JKO            = 17006899,
    }
}

return zones[ xi.zone.PERIQIA]
