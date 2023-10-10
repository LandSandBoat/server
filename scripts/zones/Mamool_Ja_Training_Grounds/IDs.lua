-----------------------------------
-- Area: Mamool_Ja_Training_Grounds
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        PLAYER_OBTAINS_ITEM           = 7319, -- <name> obtains <item>!
        ASSAULT_START_OFFSET          = 7454, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE              = 7515, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7516, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7517, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        ASSAULT_POINTS_OBTAINED       = 7519, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7520, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7521, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7523, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        BRUJEEL_TEXT                  = 7532, -- Am I glad to see you!
        PECULIAR_SENSATION            = 7545, -- <player> is overcome by a peculia sensation.
        QUHAAJA_DIALOGUE_OFFSET       = 7548, -- The time for this mission is limited. Get as many supplies as you can from those lizard bastards before time runs out. Let's give 'em hell, soldier!'
        TRAINER_DIALOGUE_OFFSET       = 7554, -- Scaleless heathen... A taste of my wrath, you shall have!
    },

    mob =
    {
        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            MOBS_START =
            {
                17047553, 17047554, 17047556, 17047557, 17047559, 17047560, 17047561, 17047563, 17047564, 17047565, 17047566,
                GATE_1 = 17047567, GATE_2 = 17047568, GATE_3 = 17047569,
            },

            GATES =
            {
                17047567, 17047568, 17047569,
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            MOBS_START =
            {
                17047570, 17047571, 17047572, 17047573, 17047574, 17047575, 17047576, 17047577, 17047578, 17047579,
                17047580, 17047581, 17047582, 17047583, 17047584, 17047585, 17047586, 17047587, 17047588, 17047589,
            },
        },
        [xi.assault.mission.BREAKING_MORALE] =
        {
            MOBS_START =
            {
                17047610, 17047611, 17047612, 17047613, 17047614, 17047615, 17047616, 17047617, 17047618,
                17047619, 17047620, 17047621, 17047622, 17047623, 17047624, 17047625, 17047626, 17047627,
            }
        }
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
