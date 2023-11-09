-----------------------------------
-- Area: Temenos
-----------------------------------
zones = zones or {}

zones[xi.zone.TEMENOS] =
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
        CHIP_TRADE_T                  = 7030, -- What do you wish to do? Show me the cutscene again. Skip the cutscene and continue.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7066, -- You have exceeded the time limit. Exiting Limbus now.
        PARTY_MEMBERS_ARE_ENGAGED     = 7067, -- You have clearance to enter Limbus, but cannot enter while you or a party member is engaged in battle.
        HUM                           = 7083, -- You hear a faint hum.
        NO_BATTLEFIELD_ENTRY          = 7088, -- There is a disc here inscribed with strange letters. There are several six-sided indentations and a thin slot in the center.
        MEMBERS_OF_YOUR_PARTY         = 7340, -- Currently, <number> party members in this area have clearance to enter Limbus.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7343, -- ou may stay in Limbus for <number> [minute/minutes].
        PARTY_MEMBERS_HAVE_FALLEN     = 7366, -- All party members in Limbus have fallen in battle. Exiting now.
        THE_PARTY_WILL_BE_REMOVED     = 7376, -- All party members in Limbus have fallen in battle. Exiting in <number> [minute/minutes].
        YOU_INSERT_THE_CARD_POLISHED  = 7381, -- You insert the <keyitem> polished with <keyitem> into the slot!
        CHIP_TRADE                    = 7382, -- The light in the <item> has grown dim.
        TIME_EXTENDED                 = 7384, -- our time in Limbus has been extended <number> [minute/minutes].
        TIME_LEFT                     = 7385, -- ou have <number> [minute/minutes] left in Limbus.
        CONQUEST_BASE                 = 7387, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7550, -- You have entered [Temenos - Northern Tower/Temenos - Eastern Tower/Temenos - Western Tower/Central Temenos - 4th Floor/Central Temenos - 3rd Floor/Central Temenos - 2nd Floor/Central Temenos - 1st Floor/Central Temenos - 1st Basement/Central Temenos - 1st Basement/Central Temenos - 4th Floor].
        CITADEL_BASE                  = 7560, -- 30...
        CANNOT_OPEN_CHEST             = 7568, -- You cannot open the treasure chest now.
        GATE_OPEN                     = 7569, -- he gate opens...
    },

    TEMENOS_NORTHERN_TOWER =
    {
        mob =
        {
            MOBLIN_DUSTMAN = 16928774,
            KARI = 16928784,
            TELCHINES_DRAGOON = 16928790,
            TELCHINES_MONK = 16928792,
            KINDRED_BLACK_MAGE = 16928802,
            CRYPTONBERRY_ABDUCTOR = 16928818,
            CRYPTONBERRY_DESIGNATOR = 16928819,
        },

        npc =
        {
            PORTAL =
            {
                16929197,
                16929198,
                16929199,
                16929200,
                16929201,
                16929202,
                16929203,
            },

            ITEM_CRATES =
            {
                16928770,
                16928779,
                16928786,
                16928795,
                16928807,
                16928814,
            },

            TIME_CRATES =
            {
                16928771,
                16928780,
                16928787,
                16928796,
                16928808,
                16928815,
            },

            RECOVER_CRATES =
            {
                16928769,
                16928778,
                16928785,
                16928794,
                16928806,
                16928813,
            },

            LOOT_CRATE = 16928830,
        },

        LINKED_CRATES =
        {
            [16932865] = { 16932866, 16932867 },
            [16928769] = { 16928770, 16928771 },
            [16928770] = { 16928769, 16928771 },
            [16928771] = { 16928769, 16928770 },
            [16928778] = { 16928779, 16928780 },
            [16928779] = { 16928778, 16928780 },
            [16928780] = { 16928778, 16928779 },
            [16928785] = { 16928786, 16928787 },
            [16928786] = { 16928785, 16928787 },
            [16928787] = { 16928785, 16928786 },
            [16928794] = { 16928795, 16928796 },
            [16928795] = { 16928794, 16928796 },
            [16928796] = { 16928794, 16928795 },
            [16928806] = { 16928807, 16928808 },
            [16928807] = { 16928806, 16928808 },
            [16928808] = { 16928806, 16928807 },
            [16928813] = { 16928814, 16928815 },
            [16928814] = { 16928813, 16928815 },
            [16928815] = { 16928813, 16928814 },
        },
    },

    TEMENOS_WESTERN_TOWER =
    {
        mob =
        {
            ENHANCED_TIGER      = 16928898,
            ENHANCED_MANDRAGORA = 16928910,
            ENHANCED_BEETLE     = 16928922,
            ENHANCED_LIZARD     = 16928931,
            ENHANCED_SLIME      = 16928943,
        },
        npc =
        {
            PORTAL =
            {
                16929211,
                16929212,
                16929213,
                16929214,
                16929215,
                16929216,
                16929217,
            },
            CRATE_OFFSETS =
            {
                16928895,
                16928907,
                16928919,
                16928928,
                16928940,
                16928949,
            },
            LOOT_CRATE = 16928958,
        },
    },

    TEMENOS_EASTERN_TOWER =
    {
        mob =
        {
            ICE_ELEMENTAL     = 16928849,
            AIR_ELEMENTAL     = 16928858,
            THUNDER_ELEMENTAL = 16928876,
        },
        npc =
        {
            PORTAL =
            {
                16929204,
                16929205,
                16929206,
                16929207,
                16929208,
                16929209,
                16929210,
            },
            CRATE_OFFSETS =
            {
                16928836,
                16928845,
                16928854,
                16928863,
                16928872,
                16928881,
                16928890,
            },
        },
    },

    CENTRAL_TEMENOS_1ST_FLOOR =
    {
        npc =
        {
            LOOT_CRATE = 16929045,
        }
    },

    CENTRAL_TEMENOS_2ND_FLOOR =
    {
        npc =
        {
            LOOT_CRATE = 16929029,
        }
    },

    CENTRAL_TEMENOS_3RD_FLOOR =
    {
        npc =
        {
            LOOT_CRATE = 16929004,
        }
    },

    CENTRAL_TEMENOS_4TH_FLOOR =
    {
        npc =
        {
            LOOT_CRATE = 16928965,
            GROUPS =
            {
                { offset = 16928967, count = 4 },
                { offset = 16928971, count = 7 },
                { offset = 16928978, count = 8 },
            },
        },
        mob =
        {
            GROUPS =
            {
                { offset = 16928986, count = 3 },
                { offset = 16928991, count = 6 },
                { offset = 16928997, count = 7 },
            },
        },
    },

    CENTRAL_TEMENOS_BASEMENT =
    {
        npc =
        {
            LOOT_CRATE = 16929052,
        }
    },
}

return zones[xi.zone.TEMENOS]
