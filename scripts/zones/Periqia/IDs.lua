-----------------------------------
-- Area: Periqia
-----------------------------------
zones = zones or {}

zones[xi.zone.PERIQIA] =
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
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        PLAYER_OBTAINS_ITEM           = 7332, -- <name> obtains <item>!
        ASSAULT_START_OFFSET          = 7467, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE              = 7528, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7529, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7530, -- Mission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-<number>).
        RUNE_UNLOCKED                 = 7531, -- Mission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED       = 7532, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7533, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7534, -- Time remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7535, -- The <keyitem> fades into nothingness...
        PARTY_FALLEN                  = 7536, -- All party members have fallen in battle. Mission failure in <number> [minute/minutes].
        EXCALIACE_START               = 7545, -- Such a lot of trouble for one little corsair... Shall we be on our way?
        EXCALIACE_END1                = 7546, -- Yeah, I got it. Stay here and keep quiet.
        EXCALIACE_END2                = 7547, -- Hey... It was a short trip, but nothing is ever dull around you, huh?
        EXCALIACE_ESCAPE              = 7548, -- Heh. The Immortals really must be having troubles finding troops if they sent this bunch of slowpokes to watch over me...
        EXCALIACE_PAIN1               = 7549, -- Oomph!
        EXCALIACE_PAIN2               = 7550, -- Ouch!
        EXCALIACE_PAIN3               = 7551, -- Youch!
        EXCALIACE_PAIN4               = 7552, -- Damn, that's gonna leave a mark!
        EXCALIACE_PAIN5               = 7553, -- Urggh!
        EXCALIACE_CRAB1               = 7554, -- Over to you.
        EXCALIACE_CRAB2               = 7555, -- What's this guy up to?
        EXCALIACE_CRAB3               = 7556, -- Uh-oh.
        EXCALIACE_DEBAUCHER1          = 7557, -- Wh-what the...!?
        EXCALIACE_DEBAUCHER2          = 7558, -- H-help!!!
        EXCALIACE_RUN                 = 7559, -- Now's my chance!
        EXCALIACE_TOO_CLOSE           = 7560, -- Okay, okay, you got me! I promise I won't run again if you step back a bit...please. Someone's been eating too much garlic...
        EXCALIACE_TIRED               = 7561, -- <Pant>...<wheeze>...
        EXCALIACE_CAUGHT              = 7562, -- Damn...
    },

    mob =
    {
        REQUIEM_UNDEAD_OFFSET = GetFirstID('Putrid_Immortal_Guard'),
    },

    npc =
    {
        ANCIENT_LOCKBOX = GetFirstID('Ancient_Lockbox'),
        RUNE_OF_RELEASE = GetFirstID('Rune_of_Release'),
        _1K6            = GetFirstID('_1k6'),
        _1KX            = GetFirstID('_1kx'),
        _1KZ            = GetFirstID('_1kz'),
        _JK1            = GetFirstID('_jk1'),
        _JK3            = GetFirstID('_jk3'),
    }
}

return zones[xi.zone.PERIQIA]
