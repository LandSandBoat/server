-----------------------------------
-- Area: Apollyon
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.APOLLYON] =
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
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7065, -- You have exceeded the time limit. Exiting Limbus now.
        PARTY_MEMBERS_ARE_ENGAGED     = 7066, -- You have clearance to enter Limbus, but cannot enter while you or a party member is engaged in battle.
        HUM                           = 7078, -- You hear a faint hum.
        NO_BATTLEFIELD_ENTRY          = 7083, -- There are several six-sided indentations and a thin slot in the center of the circular dais here.
        MEMBERS_OF_YOUR_PARTY         = 7332, -- Currently, <number> party members in this area have clearance to enter Limbus.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7335, -- ou may stay in Limbus for <number> [minute/minutes].
        PARTY_MEMBERS_HAVE_FALLEN     = 7358, -- All party members in Limbus have fallen in battle. Exiting now.
        THE_PARTY_WILL_BE_REMOVED     = 7366, -- All party members in Limbus have fallen in battle. Exiting in <number> [minute/minutes].
        YOU_INSERT_THE_CARD_POLISHED  = 7371, -- You insert the <keyitem> polished with <keyitem> into the slot!
        CHIP_TRADE                    = 7372, -- The light in the <item> has grown dim.
        TIME_EXTENDED                 = 7374, -- our time in Limbus has been extended <number> [minute/minutes].
        TIME_LEFT                     = 7375, -- ou have <number> [minute/minutes] left in Limbus.
        CONQUEST_BASE                 = 7377, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7548, -- You have entered [SW Apollyon/NW Apollyon/SE Apollyon/NE Apollyon/Central Apollyon/CS Apollyon/CS Apollyon/Central Apollyon].
        GATE_OPEN                     = 7556, -- vortex materializes...
    },
    mob =
    {

    },
    npc =
    {
        ENTRANCE_OFFSET = 16933218,
    },

    SW_APOLLYON =
    {
        mob =
        {
            JIDRA_BOSS = 16932881,
            AIR_ELEMENTAL =
            {
                16932910,
                16932918,
                16932926,
            },

            DARK_ELEMENTAL =
            {
                16932911,
                16932919,
                16932927,
            },

            EARTH_ELEMENTAL =
            {
                16932912,
                16932920,
                16932928,
            },

            FIRE_ELEMENTAL =
            {
                16932913,
                16932921,
                16932929,
            },

            ICE_ELEMENTAL =
            {
                16932914,
                16932922,
                16932930,
            },

            LIGHT_ELEMENTAL =
            {
                16932915,
                16932923,
                16932931,
            },

            WATER_ELEMENTAL =
            {
                16932916,
                16932924,
                16932932,
            },

            THUNDER_ELEMENTAL =
            {
                16932917,
                16932925,
                16932933,
            },
        },

        npc =
        {
            PORTAL =
            {
                16933230,
                16933231,
                16933232,
            },
            ITEM_CRATES =
            {
                16932865,
                16932878,
                16932896,
            },

            RECOVER_CRATES =
            {
                16932867,
                16932880,
                16932898,
            },

            TIME_CRATES =
            {
                16932866,
                16932879,
                16932897,
            },

            LOOT_CRATE = 16932909,
        },

        LINKED_CRATES =
        {
            [16932865] = { 16932866, 16932867 },
            [16932866] = { 16932865, 16932867 },
            [16932867] = { 16932865, 16932866 },
            [16932878] = { 16932879, 16932880 },
            [16932879] = { 16932878, 16932880 },
            [16932880] = { 16932878, 16932879 },
        },
    },

    SE_APOLLYON =
    {
        mob =
        {
            TIEHOLTSODI = 16933006,
            ADAMANTSHELL =
            {
                16933007,
                16933008,
                16933009,
                16933010,
                16933011,
                16933012,
                16933013,
                16933014,
            },
            FLYING_SPEAR =
            {
                16933033,
                16933034,
                16933035,
                16933036,
                16933037,
                16933038,
                16933039,
                16933040,
            }
        },
        npc =
        {
            PORTAL =
            {
                16933239,
                16933238,
                16933241,
            },
            ITEM_CRATES =
            {
                16932991,
                16933005,
                16933019,
            },
            RECOVER_CRATES =
            {
                16932990,
                16933004,
                16933018,
            },
            TIME_CRATES =
            {
                16932989,
                16933003,
                16933017,
            },
            LOOT_CRATE = 16933031,
        },
    },

    NW_APOLLYON =
    {
        mob =
        {
            PLUTO = 16932937,
            BARDHA =
            {
                16932938,
                16932939,
                16932940,
                16932941,
                16932942,
                16932943,
                16932944,
            },

            ZLATOROG = 16932950,
            MOUNTAIN_BUFFALO =
            {
                16932951,
                16932952,
                16932953,
                16932954,
                16932955,
                16932956,
                16932957,
            },

            MILLENARY_MOSSBACK = 16932963,
            APOLLYON_SCAVENGER =
            {
                16932964,
                16932965,
                16932966,
                16932967,
                16932968,
                16932969,
                16932970,
            },

            CYNOPROSOPI = 16932976,
            GORYNICH =
            {
                16932977,
                16932978,
                16932979,
                16932980,
                16932981,
            },

            KAISER_BEHEMOTH = 16932985,
        },

        npc =
        {
            PORTAL =
            {
                16933226,
                16933227,
                16933228,
                16933224,
            },
            ITEM_CRATES =
            {
                16932934,
                16932947,
                16932960,
                16932973,
            },

            RECOVER_CRATES =
            {
                16932936,
                16932949,
                16932962,
                16932983,
            },

            TIME_CRATES =
            {
                16932935,
                16932945,
                16932946,
                16932948,
                16932958,
                16932959,
                16932961,
                16932971,
                16932972,
                16932974,
                16932975,
                16932982,
            },

            LOOT_CRATE = 16932984,
        },
    },

    NE_APOLLYON =
    {
        mob =
        {
            GOOBBUE_HARVESTER = 16933044,
            APOLLYON_SWEEPER =
            {
                16933081,
                16933086,
                16933091,
            },

            TROGLODYTE_DHALMEL =
            {
                16933115,
                16933116,
                16933117,
                16933118,
                16933119,
                16933120,
                16933121,
                16933122,
            },
        },

        npc =
        {
            PORTAL =
            {
                16933235,
                16933234,
                16933233,
                16933237,
            },
            ITEM_CRATES =
            {
                16933041,
                16933059,
                16933076,
                16933096,
            },

            RECOVER_CRATES =
            {
                16933053,
                16933061,
                16933078,
                16933098,
            },

            TIME_CRATES =
            {
                16933042,
                16933043,
                16933054,
                16933060,
                16933074,
                16933075,
                16933077,
                16933079,
                16933080,
                16933097,
                16933110,
                16933111,
            },

            LOOT_CRATE = 16933112,
        },
    },

    CENTRAL_APOLLYON =
    {
        npc =
        {
            LOOT_CRATE = 16933123,
        },
    },

    CS_APOLLYON =
    {
        mob =
        {
            CARNAGECHIEF_JACKBODOKK = 16933129,
            NAQBA_CHIRURGEON = 16933137,
            DEE_WAPA_THE_DESOLATOR = 16933144,
        },

        npc =
        {
            TIME_CRATES =
            {
                16933127,
                16933128,
            },
            LOOT_CRATE = 16933126,
        },
    },
}

return zones[xi.zone.APOLLYON]
