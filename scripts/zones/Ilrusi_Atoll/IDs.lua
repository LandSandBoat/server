-----------------------------------
-- Area: Ilrusi_Atoll
-----------------------------------
zones = zones or {}

zones[xi.zone.ILRUSI_ATOLL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        ASSAULT_START_OFFSET          = 7461, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE              = 7522, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7523, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7524, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        RUNE_UNLOCKED                 = 7525, -- ission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED       = 7526, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7527, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7528, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7530, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        CHEST                         = 7540, -- The chest contains...
        GOLDEN                        = 7541, -- ...a golden figurehead!
    },
    mob =
    {
        [1] =
        {
            PERCIPIENT_FISH1 = 17002497,
            PERCIPIENT_FISH2 = 17002498,
            PERCIPIENT_FISH3 = 17002499,
            PERCIPIENT_FISH4 = 17002500,
            PERCIPIENT_FISH5 = 17002501,
            PERCIPIENT_FISH6 = 17002502,
            PERCIPIENT_FISH7 = 17002503,
            PERCIPIENT_FISH8 = 17002504,
        },
        [2] =
        {
            CURSED_CHEST1  = 17002505,
            CURSED_CHEST2  = 17002506,
            CURSED_CHEST3  = 17002507,
            CURSED_CHEST4  = 17002508,
            CURSED_CHEST5  = 17002509,
            CURSED_CHEST6  = 17002510,
            CURSED_CHEST7  = 17002511,
            CURSED_CHEST8  = 17002512,
            CURSED_CHEST9  = 17002513,
            CURSED_CHEST10 = 17002514,
            CURSED_CHEST11 = 17002515,
            CURSED_CHEST12 = 17002516,
        },

        [xi.assault.mission.EXTERMINATION] =
        {
            CARRION_MOBS = GetFirstID('Carrion_Crab'),
            UNDEAD_MOBS  = GetFirstID('Undead_Crab')
        },
    },
    npc =
    {
        ANCIENT_LOCKBOX            = GetFirstID('Ancient_Lockbox'),
        RUNE_OF_RELEASE            = GetFirstID('Rune_of_Release'),
        _1jo                       = GetFirstID('_1jo'),
        _1jp                       = GetFirstID('_1jp'),
        _jj3                       = GetFirstID('_jj3'),
        _jj5                       = GetFirstID('_jj5'),
        _jja                       = GetFirstID('_jja'),
        _jjb                       = GetFirstID('_jjb'),
        _jjc                       = GetFirstID('_jjc'),
        ILRUSI_CURSED_CHEST_OFFSET = 17002505,
        CURSED_CHEST1              = 17002505,
        CURSED_CHEST2              = 17002506,
        CURSED_CHEST3              = 17002507,
        CURSED_CHEST4              = 17002508,
        CURSED_CHEST5              = 17002509,
        CURSED_CHEST6              = 17002510,
        CURSED_CHEST7              = 17002511,
        CURSED_CHEST8              = 17002512,
        CURSED_CHEST9              = 17002513,
        CURSED_CHEST10             = 17002514,
        CURSED_CHEST11             = 17002515,
        CURSED_CHEST12             = 17002516,
    },
}

return zones[xi.zone.ILRUSI_ATOLL]
