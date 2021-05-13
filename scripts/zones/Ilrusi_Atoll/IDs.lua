-----------------------------------
-- Area: Ilrusi_Atoll
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ILRUSI_ATOLL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        ASSAULT_41_START        = 7458, -- Commencing <assault>! Objective: Rescue the agent
        ASSAULT_42_START        = 7459, -- Commencing <assault>! Objective: Destroy the assassins
        ASSAULT_43_START        = 7460, -- Commencing <assault>! Objective: Defeat Sagelord Molaal Ja
        ASSAULT_44_START        = 7461, -- Commencing <assault>! Objective: Steal the supplies
        ASSAULT_45_START        = 7462, -- Commencing <assault>! Objective: Apprehend the spy
        ASSAULT_46_START        = 7463, -- Commencing <assault>! Objective: Recover the treasure
        ASSAULT_47_START        = 7464, -- Commencing <assault>! Objective: Annihilate the enemy
        ASSAULT_48_START        = 7465, -- Commencing <assault>! Objective: Neutralize the marids
        ASSAULT_49_START        = 7466, -- Commencing <assault>! Objective: Gather pathological data
        ASSAULT_50_START        = 7467, -- Commencing <assault>! Objective: Defeat Orochi
        TIME_TO_COMPLETE        = 7508, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED          = 7509, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS       = 7510, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        RUNE_UNLOCKED           = 7511, -- ission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED = 7512, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES  = 7513, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS  = 7514, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN            = 7516, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        CHEST                   = 7526, -- The chest contains...
        GOLDEN                  = 7527, -- ...a golden figurehead!
    },

    mob =
    {
        [GOLDEN_SALVAGE] =
            MOBS_START =
            {
                17002497, 17002498, 17002499, 17002500, 17002501, 17002502, 17002503, 17002504, 17002513, 17002514, 17002515, 17002516,
            },

            ILRUSI_CURSED_CHEST_OFFSET = 17002505,
        },

        [EXTERMINATION] =
        {
            MOBS_START =
            {
                17002521, 17002522, 17002523, 17002524, 17002525, 17002526, 17002527, 17002528, 17002529, 17002530,
                17002531, 17002532, 17002533, 17002534, 17002535, 17002536, 17002537, 17002538, 17002539, 17002540,
            },

            NMS =
            {
                CRAB = 17002541, LEECH = 17002542, SLIME = 17002543, TOAD = 17002544
            },
        },
    },

    npc =
    {
        ANCIENT_LOCKBOX            = 17002654,
        RUNE_OF_RELEASE            = 17002655,
    },
}

return zones[xi.zone.ILRUSI_ATOLL]
