-----------------------------------
-- Area: Lebros_Cavern
-----------------------------------
zones = zones or {}

zones[xi.zone.LEBROS_CAVERN] =
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
        MINE_COUNTDOWN                = 6986, -- <number>...
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        TEMP_ITEM                     = 7229, -- Obtained temporary item: <item>!
        PLAYER_OBTAINS_ITEM           = 7230, -- <name> obtains <item>!
        ASSAULT_START_OFFSET          = 7365, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE              = 7426, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7427, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7428, -- Mission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-<number>).
        ASSAULT_POINTS_OBTAINED       = 7430, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7431, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7432, -- Time remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7434, -- All party members have fallen in battle. Mission failure in <number> [minute/minutes].

        -- Double check these IDs
        -- STILL_HUNGRY_FED              = 7442, -- Thank Zahak you're here. I was about to start eating my boots!
        -- FULL_FED                      = 7443, -- You brought more supplies? Well, you can never have too much...
        -- STILL_HUNGRY_TRIGGER          = 7444, -- The provisions... Have you brought the provisions?
        -- FULL_HUNGRY                   = 7445, -- There's nothing like a full belly to put the power back in your sword swing. I pity the next monster that crosses my path!
        -- HAVE_RATIONS                  = 7446, -- Why don't you deliver the rations I already gave you?
        -- DEPENDING_ON                  = 7447, -- The advance unit is depending on these provisions. Don't let them down!
        -- STEWPOT_TALK                  = 7448, -- This should keep a whole unit filled up for a while.
        -- RATIONS                       = 7449, -- There are still brave soldiers starving out there! Quickly, those rations must be delivered!
        -- SWITCH_LIGHTS_UP              = 7454, -- A switch lights up on the device... It is flickering faintly...
        -- SWITCH_WARNING                = 7455, -- The switch looks like it may cut out at any moment...
        -- SWITCH_NOTHING                = 7456, -- Nothing happens... The other switches appear to have shut down as well...
        -- SWITCHES_GLOWING              = 7457, -- The switch on the device is glowing brightly. You don't think it will fade any time soon.
        -- BORGERLUR_LOST                = 7458, -- Uggghhh... H-how did you know...? Borgerlur, lost in own clever plan...
    },

    mob =
    {
        WAMOURA_OFFSET = GetTableOfIDs('Ranch_Wamoura'),
        [xi.assault.mission.EXCAVATION_DUTY] =
        {
            MOBS_START =
            {
                17035265, 17035266, 17035267, 17035268, 17035269, 17035270, 17035271, 17035272, 17035273,
                17035274, 17035275, 17035276, 17035277, 17035278, 17035279, 17035280, 17035281,
                BRITTLE_ROCK1 = 17035283, BRITTLE_ROCK2 = 17035285, BRITTLE_ROCK3 = 17035287, BRITTLE_ROCK4 = 17035289, BRITTLE_ROCK5 = 17035291
            },
        },
        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            MOBS_START =
            {
                17035304, 17035305, 17035306, 17035307, 17035308, 17035309, CRIMSON_ERUCA1 = 17035306, CRIMSON_ERUCA2 = 17035307, CRIMSON_ERUCA3 = 17035308
            }
        },
        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            MOBS_START =
            {
                17035310, 17035311, 17035312, 17035313, 17035314, 17035315, 17035316, 17035317,
                17035318, 17035319, 17035320, 17035321, 17035322, 17035323, 17035324
            },
        },
        [xi.assault.mission.EVADE_AND_ESCAPE] = -- TODO
        {
            MOBS_START =
            {
                17035325, 17035326, 17035327
            },
        },
        [xi.assault.mission.SIEGEMASTER_ASSASSINATION] = -- TODO
        {
            MOBS_START =
            {
                17035328, 17035329, 17035330, 17035331, 17035332, 17035333, 17035334, 17035335
            },
        },
        [xi.assault.mission.APKALLU_BREEDING] = -- TODO
        {
            MOBS_START =
            {
            },
        },
        [xi.assault.mission.WAMOURA_FARM_RAID] =
        {
            MOBS_START =
            {
                17035359, 17035360, 17035361, 17035362, 17035363, 17035364, 17035365, 17035366, 17035367, 17035368,
                17035369, 17035370, 17035371, 17035372, 17035373, 17035374, 17035375, 17035376, 17035377, 17035378
            },
        },
        [xi.assault.mission.EGG_CONSERVATION] = -- TODO
        {
            MOBS_START =
            {
            },
        },
        [xi.assault.mission.OPERATION__BLACK_PEARL] = -- TODO
        {
            MOBS_START =
            {
            },
        },
        [xi.assault.mission.BETTER_THAN_ONE] = -- TODO
        {
            MOBS_START =
            {
            },
        },
    },

    npc =
    {
        ANCIENT_LOCKBOX = GetFirstID('Ancient_Lockbox'),
        RUNE_OF_RELEASE = GetFirstID('Rune_of_Release'),
        _1rx            = GetFirstID('_1rx'),
        _1ry            = GetFirstID('_1ry'),
        _1rz            = GetFirstID('_1rz'),
        _jr0            = GetFirstID('_jr0'),
        _jr1            = GetFirstID('_jr1'),

        IMPERIAL_STORMER =
        {
            17035292, 17035293, 17035294, 17035295, 17035296, 17035297, 17035298, 17035299,
            17035300, 17035301, 17035302, 17035303
        },

        SWITCHES =
        {
            SWITCH1     = 17035481,
            SWITCH2     = 17035482,
            SWITCH3     = 17035483,
        },

        BRITTLE_ROCK1   = 17035538,
        BRITTLE_ROCK2   = 17035539,
        BRITTLE_ROCK3   = 17035540,
        BRITTLE_ROCK4   = 17035541,
        BRITTLE_ROCK5   = 17035542,
        QIQIRN_MINE1    = 17037312,
        QIQIRN_MINE2    = 17037313,
        QIQIRN_MINE3    = 17037314,
        QIQIRN_MINE4    = 17037315
    }
}

return zones[xi.zone.LEBROS_CAVERN]
