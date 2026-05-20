-----------------------------------
-- Area: The_Ashu_Talif (60)
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_ASHU_TALIF] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6389, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6396, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6400, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_TO_COMPLETE              = 7419, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7420, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7424, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7425, -- ime remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7426, -- The <item> fades into nothingness...
        PARTY_FALLEN                  = 7427, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        GOWAM_DEATH                   = 7574, -- Ugh...
        YAZQUHL_CORSAIR_COULD         = 7575, -- Did you really think a corsair could defeat me? Ludicrous.
        YAZQUHL_ENGAGE                = 7576, -- No need for worry, corsairs... You will be a fitting sacrifice for the Empire!
        YAZQUHL_DEATH                 = 7577, -- Defeated...by a corsair...?
        TAKE_THIS                     = 7578, -- Take this!
        REST_BENEATH                  = 7579, -- Time for you to rest beneath the waves!
        STOP_US                       = 7580, -- There's nothing you can do to stop us!
        YOU_WILL_REGRET               = 7581, -- You will regret for eternity the day you turned agains the Empire!
        BATTLE_HIGH_SEAS              = 7582, -- A battle on the high seas? My warrior's spirit soars in anticipation!
        TIME_IS_NEAR                  = 7583, -- My time is near...
        SO_I_FALL                     = 7584, -- And so I fall...
        SWIFT_AS_LIGHTNING            = 7585, -- Swift as lightning...!
        HARNESS_THE_WHIRLWIND         = 7586, -- Harness the whirlwind...!
        STING_OF_MY_BLADE             = 7587, -- Feel the sting of my blade!
        UNNATURAL_CURS                = 7588, -- Unnatural curs!
        OVERPOWERED_CREW              = 7589, -- You have overpowered my crew...
        TEST_YOUR_BLADES              = 7590, -- I will test your blades. Prepare to join your ancestors...
        FOR_THE_BLACK_COFFIN          = 7591, -- For the Black Coffin!
        FOR_EPHRAMAD                  = 7592, -- For Ephramad!
        TROUBLESOME_SQUABS            = 7593, -- Troublesome squabs...
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
