-----------------------------------
-- Area: Ilrusi_Atoll
-----------------------------------
zones = zones or {}

zones[xi.zone.ILRUSI_ATOLL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        PLAYER_OBTAINS_ITEM           = 7331, -- <name> obtains <item>!
        ASSAULT_START_OFFSET          = 7466, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE              = 7527, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7528, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7529, -- Mission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-<number>).
        RUNE_UNLOCKED                 = 7530, -- Mission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED       = 7531, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7532, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7533, -- Time remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7535, -- All party members have fallen in battle. Mission failure in <number> [minute/minutes].
        MUST_BE_CLOSER_TO_OPEN_CHEST  = 7544, -- You must be the party's [leader/leader or a member of the alliance] to open this chest.
        CHEST                         = 7545, -- The chest contains...
        GOLDEN                        = 7546, -- ...a golden figurehead!
    },
    mob =
    {
        -- Golden Salvage.
        CURSED_CHEST_OFFSET    = GetFirstID('Cursed_Chest'),
        PERCIPIENT_FISH_OFFSET = GetFirstID('Percipient_Fish'),

        -- TODO: Convert and destroy tabled pattern.
        [43] =
        {
            CARRION_CRAB1   = 17002521,
            CARRION_LEECH1  = 17002522,
            CARRION_CRAB2   = 17002523,
            CARRION_CRAB3   = 17002524,
            CARRION_LEECH2  = 17002525,
            CARRION_CRAB4   = 17002526,
            CARRION_CRAB5   = 17002527,
            CARRION_CRAB6   = 17002528,
            CARRION_SLIME1  = 17002529,
            CARRION_SLIME2  = 17002530,
            CARRION_SLIME3  = 17002531,
            CARRION_CRAB7   = 17002532,
            CARRION_LEECH3  = 17002533,
            CARRION_LEECH4  = 17002534,
            CARRION_LEECH5  = 17002535,
            CARRION_LEECH6  = 17002536,
            CARRION_LEECH7  = 17002537,
            CARRION_LEECH8  = 17002538,
            CARRION_TOAD1   = 17002539,
            CARRION_TOAD2   = 17002540,
            UNDEAD_CRAB     = 17002541,
            UNDEAD_LEECH    = 17002542,
            UNDEAD_SLIME    = 17002543,
            UNDEAD_TOAD     = 17002544,
        },
    },

    npc =
    {
        _1ji                       = GetFirstID('_1ji'), -- Zone obstacle.
        _1jj                       = GetFirstID('_1jj'), -- Zone obstacle.
        _1jo                       = GetFirstID('_1jo'), -- Zone obstacle.
        _1jp                       = GetFirstID('_1jp'), -- Zone obstacle.
        _1jq                       = GetFirstID('_1jq'), -- Zone obstacle.
        _jja                       = GetFirstID('_jja'), -- Zone obstacle.
        _jjb                       = GetFirstID('_jjb'), -- Zone obstacle.

        ANCIENT_LOCKBOX            = GetFirstID('Ancient_Lockbox'),
        CURSED_CHEST_OFFSET        = GetFirstID('Cursed_Chest'),
        RUNE_OF_RELEASE            = GetFirstID('Rune_of_Release'),
    },
}

return zones[xi.zone.ILRUSI_ATOLL]
