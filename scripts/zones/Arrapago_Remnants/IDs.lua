-----------------------------------
-- Area: Arrapago_Remnants
-----------------------------------
zones = zones or {}

zones[xi.zone.ARRAPAGO_REMNANTS] =
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
        CELL_OFFSET                   = 7221, -- Main Weapon/Sub-Weapon restriction removed.
        SALVAGE_START                 = 7244, -- You feel an incredible pressure bearing down on you. This area appears to be blanketed in some sort of intense psionic field...
        TIME_TO_COMPLETE              = 7451, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7452, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7456, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7457, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7459, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        DOOR_IS_SEALED                = 7470, -- The door is sealed...
        DOOR_IS_SEALED_MYSTERIOUS     = 7473, -- The door is sealed by some mysterious force...
    },
    mob =
    {
        [1] =
        {
            [2] =
            {
                mobs_start = 17080323,
                mobs_end   = 17080395,
                rampart    = 17080321,
                sabotender = 17080322,
            }
        },

        [2] =
        {
            [0] =
            {
                astrologer = 17080431,
            },

            [1] =
            {
                mobs_start = 17080421,
                mobs_end   = 17080430,
            },

            [2] =
            {
                mobs_start = 17080413,
                mobs_end   = 17080420,
                princess   = 17080597,
            },

            [3] =
            {
                mobs_start = 17080404,
                mobs_end   = 17080412,
                wahzil     = 17080596,
            },

            [4] =
            {
                mobs_start = 17080396,
                mobs_end   = 17080403,
            },
        },

        [3] =
        {
            [1] =
            {
                mobs_start = 17080432,
                mobs_end   = 17080451,
            },

            [2] =
            {
                mobs_start = 17080454,
                mobs_end   = 17080474,
            },

            treasure_hunter1 = 17080452,
            qiqirn_mine_1    = 17080453,
            treasure_hunter2 = 17080475,
            qiqirn_mine_2    = 17080476,
        },

        [4] =
        {
            [1] =
            {
                mobs_start = 17080477,
                mobs_end   = 17080489,
                rampart2   = 17080492,
            },

            [2] =
            {
                mobs_start = 17080497,
                mobs_end   = 17080509,
                rampart2   = 17080512,
            },

            treasure_hunter1 = 17080514,
            qiqirn_mine_1    = 17080515,
            treasure_hunter2 = 17080495,
            qiqirn_mine_2    = 17080496,
        },

        [5] =
        {
            [1] =
            {
                [1] =
                {
                mobs_start = 17080516,
                mobs_end   = 17080519,
                },

                [2] =
                {
                mobs_start = 17080521,
                mobs_end   = 17080522,
                },

                [3] =
                {
                mobs_start = 17080526,
                mobs_end   = 17080530,
                },

                astrologer = 17080520,
                rampart1   = 17080523,
                rampart2   = 17080533,
                chariot    = 17080537,
            },
            [2] =
            {
                [1] =
                {
                mobs_start = 17080538,
                mobs_end   = 17080541,
                },

                [2] =
                {
                mobs_start = 17080543,
                mobs_end   = 17080544,
                },

                [3] =
                {
                mobs_start = 17080549,
                mobs_end   = 17080553,
                },

                astrologer = 17080542,
                rampart1   = 17080545,
                chariot    = 17080558,
            },
        },

        [6] =
        {
            [1] =
            {
                mobs_start = 17080562,
                mobs_end   = 17080569,
            },

            rampart1 = 17080559,
            rampart2 = 17080570,
            rampart3 = 17080577,
            rampart4 = 17080581,
            treasure_hunter1 = 17080573,
            qiqirn_mine_1    = 17080574,
            treasure_hunter2 = 17080575,
            qiqirn_mine_2    = 17080576,
        },

        [7] =
        {
            [1] =
            {
                chariot = 17080585,
            },
        },
    },

    npc =
    {
        [1] =
        {
            [1] =
            {
                DOOR1 = 17080974,
            },

            [2] =
            {
                ARMORY_CRATE = 17080586,
            },

            [3] =
            {
                DOOR1 = 17080975,
                DOOR2 = 17080976,
                DOOR3 = 17080977,
                DOOR4 = 17080978,
            },
        },

        [2] =
        {
            [1] =
            {
                DOOR1 = 17080979,
                DOOR2 = 17080980,
                DOOR3 = 17080981,
                DOOR4 = 17080982,
            },

            [2] =
            {
                SOCKET = 17080941,
                SLOT   = 17080942,
            },
        },

        [3] =
        {
            [1] =
            {
                DOOR1 = 17080983,
                DOOR2 = 17080984,
            },
        },

        [4] =
        {
            [1] =
            {
                DOOR1 = 17080985,
                DOOR2 = 17080986,
            },
        },

        [5] =
        {
            [1] =
            {
                DOOR1 = 17080987,
                DOOR2 = 17080988,
            },
        },

        [6] =
        {
            DOOR = 17080989,
        },
    },

    points =
    {
        [3] =
        {
            [0] = -- 2nd Floor Astrologer
            {
                point1 =
                {
                    302, -2, 99,
                },

                point2 =
                {
                    309, -4, 99,
                },

                point3 =
                {
                    319, -4, 100,
                },

                point4 =
                {
                    330, -4, 101,
                },

                point5 =
                {
                    335, -3, 113,
                },

                point6 =
                {
                    340, -3, 109,
                },
            },
        },

        [4] =
        {
            [2] = -- 3rd Floor S Treasure Hunter
            {
                route =
                {
                    380, -4, 422,
                    379, -4, 373,
                    300, -4, 371,
                    300, -4, 421,
                    219, -4, 420,
                    224, -3, 461,
                    217, -4, 499,
                    260, -4, 500,
                    260, -4, 459,
                    339, 0, 460,
                    260, -4, 459,
                    260, -4, 500,
                    217, -4, 499,
                    224, -3, 461,
                    219, -4, 420,
                    300, -4, 421,
                    300, -4, 371,
                    379, -4, 373,
                    380, -4, 422,
                },
            },

            [3] = -- 3rd Floor N Treasure Hunter
            {
                route =
                {
                    300, -4, 497,
                    300, -4, 548,
                    379, -4, 549,
                    380, -4, 499,
                    460, -4, 500,
                    462, -4, 459,
                    458, -4, 419,
                    419, -4, 420,
                    419, -4, 460,
                    340, 0, 459,
                    419, -4, 460,
                    419, -4, 420,
                    458, -4, 419,
                    462, -4, 459,
                    460, -4, 500,
                    380, -4, 499,
                    379, -4, 549,
                    300, -4, 548,
                    300, -4, 497,
                },
            },
        },

        [5] =
        {
            [2] = -- 4th Floor S Treasure Hunter
            {
                route =
                {
                    -377, 0, -579,
                    -340, 0, -580,
                    -377, 0, -579,
                    -382, 0, -608,
                    -377, 0, -579,
                    -340, 0, -580,
                    -377, 0, -579,
                },
            },

            [3] = -- 4th Floor N Treasure Hunter
            {
                route =
                {
                    -301, 0, -499,
                    -339, 0, -500,
                    -301, 0, -499,
                    -298, 0, -472,
                    -301, 0, -499,
                    -339, 0, -500,
                    -301, 0, -499,
                },
            },
        },

        [6] =
        {
            [1] = --5th Floor S Astrologer
            {
                point1 =
                {
                    -340, 3, -160,
                },
                point2 =
                {
                    -340, 0, -202,
                },
                point3 =
                {
                    -354, 0, -219,
                },
                point4 =
                {
                    -380, 0, -219,
                },
                point5 =
                {
                    -380, 0, -198,
                },
                point6 =
                {
                    -380, 0, -180,
                },
            },

            [2] = --5th Floor N Astrologer
            {
                point1 =
                {
                    -339, -4, -35,
                },
                point2 =
                {
                    -340, 0, -11,
                },
                point3 =
                {
                    -333, 0, 21,
                },
                point4 =
                {
                    -300, 0, 19,
                },
                point5 =
                {
                    -299, 0, 0,
                },
                point6 =
                {
                    -300, 0, -19,
                },
            },
        },

        [7] =
        {
            [0] = -- Floor 6 2x Treasure Hunters
            {
                route =
                {
                    -413, 0, 219,
                    -340, 0, 219,
                },
            },
        },
    },
}

return zones[xi.zone.ARRAPAGO_REMNANTS]
