-----------------------------------
-- Area: Temenos
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.TEMENOS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CHIP_TRADE_T            = 7028, -- What do you wish to do? Show me the cutscene again. Skip the cutscene and continue.
        TIME_EXCEEDED           = 7054, -- You have exceeded the time limit. Exiting Limbus now.
        WIPE_KICK               = 7354, -- All party members in Limbus have fallen in battle. Exiting now.
        WIPE                    = 7364, -- All party members in Limbus have fallen in battle. Exiting in <number> [minute/minutes].
        CONDITION_FOR_LIMBUS_T  = 7055, -- You have clearance to enter Limbus, but cannot enter while you or a party member is engaged in battle.
        HUM                     = 7071, -- You hear a faint hum.
        NO_KEY                  = 7076, -- There is a disc here inscribed with strange letters. There are several six-sided indentations and a thin slot in the center.
        TIME_EXTENDED           = 7372, -- our time in Limbus has been extended <number> [minute/minutes].
        TIME_LEFT               = 7373, -- ou have <number> [minute/minutes] left in Limbus.
        CONQUEST_BASE           = 7375, -- Tallying conquest results...
        CITADEL_BASE            = 7548, -- 30...
        CANNOT_OPEN_CHEST       = 7556, -- You cannot open the treasure chest now.
        GATE_OPEN               = 7557, -- he gate opens...
    },
    mob =
    {
        TEMENOS_N_MOB =
        {
            16928772,
            16928781,
            16928788,
            16928797,
            16928809,
            16928816,
            16928831,
        },
        TEMENOS_E_MOB =
        {
            16928840,
            16928849,
            16928858,
            16928867,
            16928876,
            16928885,
            16928892,
        },
        TEMENOS_W_MOB =
        {
            16928898,
            16928910,
            16928922,
            16928931,
            16928943,
            16928952,
            16928959,
        },
        TEMENOS_C_MOB =
        {
            16929046,
            16929030,
            16929005,
            16928966,
            16929053,
        }
    },
    npc =
    {
        TEMENOS_N_GATE =
        {
            16929197,
            16929198,
            16929199,
            16929200,
            16929201,
            16929202,
            16929203,
        },
        TEMENOS_E_GATE =
        {
            16929204,
            16929205,
            16929206,
            16929207,
            16929208,
            16929209,
            16929210,
        },
        TEMENOS_W_GATE =
        {
            16929211,
            16929212,
            16929213,
            16929214,
            16929215,
            16929216,
            16929217,
        },
        TEMENOS_C_GATE =
        {
            16929219,
            16929220,
            16929221,
            16929222,
            16929218,
        },
        TEMENOS_N_CRATE =
        {
            16928769,
            16928778,
            16928785,
            16928794,
            16928806,
            16928813,
            16928830,
        },
        TEMENOS_E_CRATE =
        {
            16928836,
            16928845,
            16928854,
            16928863,
            16928872,
            16928881,
            16928890,
        },
        TEMENOS_W_CRATE =
        {
            16928895,
            16928907,
            16928919,
            16928928,
            16928940,
            16928949,
            16928958,
        },
        TEMENOS_C_CRATE =
        {
            16929045,
            16929029,
            16929004,
            [4] =
            {
                [1] = 16928965, -- boss
                [16928967] = 1, -- NE corner
                [16928968] = 1, -- SE corner
                [16928969] = 1, -- SW corner
                [16928970] = 1, -- NW corner
                [16928971] = 2, -- center
                [16928972] = 2, -- E
                [16928973] = 2, -- E
                [16928974] = 2, -- E
                [16928975] = 2, -- W
                [16928976] = 2, -- W
                [16928977] = 2, -- W
                [16928978] = 3, -- SW
                [16928979] = 3, -- SW
                [16928980] = 3, -- SW
                [16928981] = 3, -- SW
                [16928982] = 3, -- SE
                [16928983] = 3, -- SE
                [16928984] = 3, -- SE
                [16928985] = 3, -- SE
            },
            [5] = 16929052, -- basement 1 boss
        },
    },
}

return zones[tpz.zone.TEMENOS]
