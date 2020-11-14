-----------------------------------
-- Area: The_Ashu_Talif
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.THE_ASHU_TALIF] =
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
        CARRIED_OVER_POINTS        = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY    = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER               = 7001, -- In celebration of your most recent login no. <number>...
        TIME_TO_COMPLETE           = 7403, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED             = 7404, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES     = 7408, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS     = 7409, -- ime remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS     = 7410, -- The <item> fades into nothingness...
        PARTY_FALLEN               = 7411, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        GOWAM_DEATH                = 7558, -- Ugh...
        YAZQUHL_DEATH              = 7561, -- Defeated...by a corsair...?
        TAKE_THIS                  = 7562, -- Take this!
        REST_BENEATH               = 7563, -- Time for you to rest beneath the waves!
        STOP_US                    = 7564, -- There's nothing you can do to stop us!
        BATTLE_HIGH_SEAS           = 7566, -- A battle on the high seas? My warrior's spirit soars in anticipation!
        TIME_IS_NEAR               = 7567, -- My time is near...
        SO_I_FALL                  = 7568, -- And so I fall...
        SWIFT_AS_LIGHTNING         = 7569, -- Swift as lightning...!
        HARNESS_THE_WHIRLWIND      = 7570, -- Harness the whirlwind...!
        STING_OF_MY_BLADE          = 7571, -- Feel the sting of my blade!
        UNNATURAL_CURS             = 7572, -- Unnatural curs!
        OVERPOWERED_CREW           = 7573, -- You have overpowered my crew...
        TEST_YOUR_BLADES           = 7574, -- I will test your blades. Prepare to join your ancestors...
        FOR_THE_BLACK_COFFIN       = 7575, -- For the Black Coffin!
        FOR_EPHRAMAD               = 7576, -- For Ephramad!
        TROUBLESOME_SQUABS         = 7577, -- Troublesome squabs...
    },
    mob =
    {
        -- The Black Coffin - Wave 1
        GESSHO = 17022979,
        [1]    = {
            ASHU_TALIF_CREW_1 = 17022980,
            ASHU_TALIF_CREW_2 = 17022981,
            ASHU_TALIF_CREW_3 = 17022982,
            ASHU_TALIF_CREW_4 = 17022983,
            ASHU_TALIF_CREW_5 = 17022984,
        },
        -- The Black Coffin - Wave 2
        [2]   = {
            ASHU_TALIF_CAPTAIN = 17022985,
            ASHU_TALIF_CREW_6  = 17022986,
            ASHU_TALIF_CREW_7  = 17022987,
            ASHU_TALIF_CREW_8  = 17022988,
            ASHU_TALIF_CREW_9  = 17022989,
        },
        -- Against All Odds - Cor AF2
        [54]    = {
            GOWAM              = 17022977,
            YAZQUHL            = 17022978,
        },
    },
    npc =
    {
    },
}

return zones[tpz.zone.THE_ASHU_TALIF]
