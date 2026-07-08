-----------------------------------
-- Area: The_Ashu_Talif (60)
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_ASHU_TALIF] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6390, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6398, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6399, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6403, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_TO_COMPLETE              = 7423, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7424, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7428, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7429, -- Time remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7430, -- The <item> fades into nothingness...
        PARTY_FALLEN                  = 7431, -- All party members have fallen in battle. Mission failure in <number> [minute/minutes].
        GOWAM_DEATH                   = 7578, -- Ugh...
        YAZQUHL_CORSAIR_COULD         = 7579, -- Did you really think a corsair could defeat me? Ludicrous.
        YAZQUHL_ENGAGE                = 7580, -- No need for worry, corsairs... You will be a fitting sacrifice for the Empire!
        YAZQUHL_DEATH                 = 7581, -- Defeated...by a corsair...?
        TAKE_THIS                     = 7582, -- Take this!
        REST_BENEATH                  = 7583, -- Time for you to rest beneath the waves!
        STOP_US                       = 7584, -- There's nothing you can do to stop us!
        YOU_WILL_REGRET               = 7585, -- You will regret for eternity the day you turned against the Empire!
        BATTLE_HIGH_SEAS              = 7586, -- A battle on the high seas? My warrior's spirit soars in anticipation!
        TIME_IS_NEAR                  = 7587, -- My time is near...
        SO_I_FALL                     = 7588, -- And so I fall...
        SWIFT_AS_LIGHTNING            = 7589, -- Swift as lightning...!
        HARNESS_THE_WHIRLWIND         = 7590, -- Harness the whirlwind...!
        STING_OF_MY_BLADE             = 7591, -- Feel the sting of my blade!
        UNNATURAL_CURS                = 7592, -- Unnatural curs!
        OVERPOWERED_CREW              = 7593, -- You have overpowered my crew...
        TEST_YOUR_BLADES              = 7594, -- I will test your blades. Prepare to join your ancestors...
        FOR_THE_BLACK_COFFIN          = 7595, -- For the Black Coffin!
        FOR_EPHRAMAD                  = 7596, -- For Ephramad!
        TROUBLESOME_SQUABS            = 7597, -- Troublesome squabs...
    },

    mob =
    {
        GESSHO              = GetFirstID('Gessho'),
        ASHU_CREW_OFFSET    = GetFirstID('Ashu_Talif_Crew_mnk'),
        ASHU_CAPTAIN_OFFSET = GetFirstID('Ashu_Talif_Captain'),
        GOWAM               = GetFirstID('Gowam'),
        YAZQUHL             = GetFirstID('Yazquhl'),
    },

    npc =
    {
    },
}

return zones[xi.zone.THE_ASHU_TALIF]
