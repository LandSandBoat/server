-----------------------------------
-- Area: Periqia
-----------------------------------
zones = zones or {}

zones[xi.zone.PERIQIA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6395, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6399, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        PLAYER_OBTAINS_ITEM           = 7319, -- <name> obtains <item>!
        ASSAULT_START_OFFSET          = 7454, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE              = 7515, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7516, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7517, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        RUNE_UNLOCKED                 = 7518, -- ission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED       = 7519, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7520, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7521, -- ime remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7522, -- The <keyitem> fades into nothingness...
        PARTY_FALLEN                  = 7523, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        EXCALIACE_START               = 7532, -- Such a lot of trouble for one little corsair... Shall we be on our way?
        EXCALIACE_END1                = 7533, -- Yeah, I got it. Stay here and keep quiet.
        EXCALIACE_END2                = 7534, -- Hey... It was a short trip, but nothing is ever dull around you, huh?
        EXCALIACE_ESCAPE              = 7535, -- Heh. The Immortals really must be having troubles finding troops if they sent this bunch of slowpokes to watch over me...
        EXCALIACE_PAIN1               = 7536, -- Oomph!
        EXCALIACE_PAIN2               = 7537, -- Ouch!
        EXCALIACE_PAIN3               = 7538, -- Youch!
        EXCALIACE_PAIN4               = 7539, -- Damn, that's gonna leave a mark!
        EXCALIACE_PAIN5               = 7540, -- Urggh!
        EXCALIACE_CRAB1               = 7541, -- Over to you.
        EXCALIACE_CRAB2               = 7542, -- What's this guy up to?
        EXCALIACE_CRAB3               = 7543, -- Uh-oh.
        EXCALIACE_DEBAUCHER1          = 7544, -- Wh-what the...!?
        EXCALIACE_DEBAUCHER2          = 7545, -- H-help!!!
        EXCALIACE_RUN                 = 7546, -- Now's my chance!
        EXCALIACE_TOO_CLOSE           = 7547, -- Okay, okay, you got me! I promise I won't run again if you step back a bit...please. Someone's been eating too much garlic...
        EXCALIACE_TIRED               = 7548, -- <Pant>...<wheeze>...
        EXCALIACE_CAUGHT              = 7549, -- Damn...
    },

    mob =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            MOBS_START =
            {
                EXCALIAC = 17006593, 17006594, 17006595, 17006596, 17006597, 17006598, 17006599, 17006600, 17006601,
                17006602, 17006603, 17006604, 17006605, 17006606, 17006607, 17006608, 17006610, 17006611,
            },
        },
        [xi.assault.mission.REQUIEM] =
        {
            MOBS_START =
            {
                17006612, 17006613, 17006614, 17006615, 17006616, 17006617, 17006619, 17006620, 17006621,
                17006623, 17006625, 17006626, 17006627, 17006628, 17006630, 17006631, 17006633, 17006634,
            },
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
        ANCIENT_LOCKBOX = 17006809,
        RUNE_OF_RELEASE = 17006810,
        _1K6            = 17006845,
        _1KX            = 17006872,
        _1KZ            = 17006874,
        _JK1            = 17006876,
        _JK3            = 17006878,
    }
}

return zones[xi.zone.PERIQIA]
