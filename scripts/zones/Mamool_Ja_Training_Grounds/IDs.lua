-----------------------------------
-- Area: Mamool_Ja_Training_Grounds
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS] =
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
        ASSAULT_11_START        = 7458, -- Commencing <assault>! Objective: Rescue the agent
        ASSAULT_12_START        = 7459, -- Commencing <assault>! Objective: Destroy the assassins
        ASSAULT_13_START        = 7460, -- Commencing <assault>! Objective: Defeat Sagelord Molaal Ja
        ASSAULT_14_START        = 7461, -- Commencing <assault>! Objective: Steal the supplies
        ASSAULT_15_START        = 7462, -- Commencing <assault>! Objective: Apprehend the spy
        ASSAULT_16_START        = 7463, -- Commencing <assault>! Objective: Recover the treasure
        ASSAULT_17_START        = 7464, -- Commencing <assault>! Objective: Annihilate the enemy
        ASSAULT_18_START        = 7465, -- Commencing <assault>! Objective: Neutralize the marids
        ASSAULT_19_START        = 7466, -- Commencing <assault>! Objective: Gather pathological data
        ASSAULT_20_START        = 7467, -- Commencing <assault>! Objective: Defeat Orochi
        PLAYER_OBTAINS_ITEM     = 7312, -- <name> obtains <item>!
        ASSAULT_START_OFFSET    = 7447, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE        = 7508, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED          = 7509, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS       = 7510, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        RUNE_UNLOCKED           = 7511, -- ission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED = 7512, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES  = 7513, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS  = 7514, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN            = 7516, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        BRUJEEL_TEXT            = 7525, -- Am I glad to see you!
    },

    mob =
    {
        [IMPERIAL_AGENT_RESCUE] =
        {
            MOBS_START =
            {
                17047553, 17047554, 17047556, 17047557, 17047559, 17047560, 17047561, 17047563, 17047564, 17047565, 17047566,
                GATE_1 = 17047567, GATE_2 = 17047568, GATE_3 = 17047569,
            },
            GATES      =
            {
                17047567, 17047568, 17047569,
            },
        },

        [PREEMPTIVE_STRIKE] =
        {
            MOBS_START =
            {
                17047570, 17047571, 17047572, 17047573, 17047574, 17047575, 17047576, 17047577, 17047578, 17047579,
                17047580, 17047581, 17047582, 17047583, 17047584, 17047585, 17047586, 17047587, 17047588, 17047589,
            },
        },
    },

    npc =
    {
        ANCIENT_LOCKBOX = 17047808,
        RUNE_OF_RELEASE = 17047809,
        BRUJEEL         = 17047810,
        DOOR_1          = 17047898, -- north
        DOOR_2          = 17047900, -- southwest
        DOOR_3          = 17047902, -- southest
        POT_HATCH       = 17047916,
    },
}

return zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
