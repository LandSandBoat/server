-----------------------------------
-- Area: Dynamis-Beaucedine
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.DYNAMIS_BEAUCEDINE] =
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
        CONQUEST_BASE           = 7156, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7315, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7316, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7317, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7318, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7320, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE        = 7332, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            {minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = 17326207},
            {minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 17326279},
            {minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 17326353},
            {minutes = 10, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 17326468},
            {minutes = 20, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = {17326742, 17326748, 17326754, 17326760, 17326765, 17326771}},
        },
        REFILL_STATUE =
        {
            {
                {mob = 17326203, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17326204, eye = dynamis.eye.BLUE },
            },
            {
                {mob = 17326205, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17326206, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17326275, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 17326276, eye = dynamis.eye.BLUE },
            },
            {
                {mob = 17326277, eye = dynamis.eye.RED  }, -- Serjeant_Tombstone
                {mob = 17326278, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17326349, eye = dynamis.eye.RED  }, -- Avatar_Icon
                {mob = 17326350, eye = dynamis.eye.BLUE },
            },
            {
                {mob = 17326351, eye = dynamis.eye.RED  }, -- Avatar_Icon
                {mob = 17326352, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17326464, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17326465, eye = dynamis.eye.BLUE },
            },
            {
                {mob = 17326466, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17326467, eye = dynamis.eye.GREEN},
            },
        },
        MOLTENOX_STUBTHUMBS_PH      = {[17326372] = 17326374}, -- Vanguard_Smithy
        DROPRIX_GRANITEPALMS_PH     = {[17326377] = 17326379}, -- Vanguard_Pitfighter
        BREWNIX_BITTYPUPILS_PH      = {[17326390] = 17326387}, -- Vanguard_Alchemist
        ASCETOX_RATGUMS_PH          = {[17326395] = 17326397}, -- Vanguard_Shaman
        GIBBEROX_PIMPLEBEAK_PH      = {[17326400] = 17326401}, -- Vanguard_Enchanter
        BORDOX_KITTYBACK_PH         = {[17326408] = 17326410}, -- Vanguard_Welldigger
        RUFFBIX_JUMBOLOBES_PH       = {[17326413] = 17326415}, -- Vanguard_Armorer
        TOCKTIX_THINLIDS_PH         = {[17326425] = 17326427}, -- Vanguard_Tinkerer
        ROUTSIX_RUBBERTENDON_PH     = {[17326437] = 17326439}, -- Vanguard_Pathfinder
        WHISTRIX_TOADTHROAT_PH      = {[17326451] = 17326452}, -- Vanguard_Maestro
        SLINKIX_TRUFFLESNIFF_PH     = {[17326457] = 17326458}, -- Vanguard_Ambusher
        SHISOX_WIDEBROW_PH          = {[17326461] = 17326463}, -- Vanguard_Ronin
        SWYPESTIX_TIGERSHINS_PH     = {[17326403] = 17326405}, -- Vanguard_Hitman
        DRAKLIX_SCALECRUST_PH       = {[17326419] = 17326421}, -- Vanguard_Dragontamer
        MORBLOX_CHUBBYCHIN_PH       = {[17326444] = 17326446}, -- Vanguard_Necromancer
        HUMEGUTTER_ADZJBADJ_PH      = {[17326211] = 17326212}, -- Vanguard_Footsoldier
        COBRACLAW_BUCHZVOTCH_PH     = {[17326217] = 17326218}, -- Vanguard_Grappler
        WRAITHDANCER_GIDBNOD_PH     = {[17326221] = 17326223}, -- Vanguard_Amputator
        TARUROASTER_BIGGSJIG_PH     = {[17326261] = 17326262}, -- Vanguard_Mesmerizer
        SPINALSUCKER_GALFLMALL_PH   = {[17326236] = 17326237}, -- Vanguard_Vexer
        LOCKBUSTER_ZAPDJIPP_PH      = {[17326241] = 17326243}, -- Vanguard_Pillager
        HEAVYMAIL_DJIDZBAD_PH       = {[17326247] = 17326248}, -- Vanguard_Trooper
        SKINMASK_UGGHFOGG_PH        = {[17326257] = 17326258}, -- Vanguard_Neckchopper
        MITHRASLAVER_DEBHABOB_PH    = {[17326263] = 17326265}, -- Vanguard_Hawker
        ULTRASONIC_ZEKNAJAK_PH      = {[17326267] = 17326270}, -- Vanguard_Bugler
        GALKARIDER_RETZPRATZ_PH     = {[17326227] = 17326229}, -- Vanguard_Predator
        ELVAANLOPPER_GROKDOK_PH     = {[17326254] = 17326255}, -- Vanguard_Gutslasher
        JEUNORAIDER_GEPKZIP_PH      = {[17326215] = 17326216}, -- Vanguard_Backstabber
        DRAKEFEAST_WUBMFUB_PH       = {[17326271] = 17326273}, -- Vanguard_Impaler
        DEATHCALLER_BIDFBID_PH      = {[17326231] = 17326233}, -- Vanguard_Dollmaster
        GUNHA_WALLSTORMER_PH        = {[17326100] = 17326106}, -- Vanguard_Vindicator
        SOZHO_METALBENDER_PH        = {[17326167] = 17326168}, -- Vanguard_Militant
        GAFHO_VENOMTOUCH_PH         = {[17326134] = 17326135}, -- Vanguard_Constable
        DEBHO_PYROHAND_PH           = {[17326153] = 17326156}, -- Vanguard_Thaumaturge
        NAHYA_FLOODMAKER_PH         = {[17326109] = 17326114}, -- Vanguard_Protector
        JIFHU_INFILTRATOR_PH        = {[17326121] = 17326126}, -- Vanguard_Purloiner
        MUGHA_LEGIONKILLER_PH       = {[17326171] = 17326173}, -- Vanguard_Defender
        TAHYU_GALLANTHUNTER_PH      = {[17326139] = 17326145}, -- Vanguard_Vigilante
        SOGHO_ADDERHANDLER_PH       = {[17326177] = 17326179}, -- Vanguard_Beasttender
        NUBHI_SPIRALEYE_PH          = {[17326150] = 17326151}, -- Vanguard_Minstrel
        GUKHU_DUKESNIPER_PH         = {[17326184] = 17326185}, -- Vanguard_Mason
        JIKHU_TOWERCLEAVER_PH       = {[17326189] = 17326190}, -- Vanguard_Hatamoto
        MIRHE_WHISPERBLADE_PH       = {[17326194] = 17326195}, -- Vanguard_Kusa
        GOTYO_MAGENAPPER_PH         = {[17326157] = 17326162}, -- Vanguard_Drakekeeper
        BEZHE_KEEPRAZER_PH          = {[17326199] = 17326201}, -- Vanguard_Undertaker
        FOO_PEKU_THE_BLOODCLOAK_PH  = {[17326282] = 17326284}, -- Vanguard_Skirmisher
        XAA_CHAU_THE_ROCTALON_PH    = {[17326288] = 17326289}, -- Vanguard_Sentinel
        KOO_SAXU_THE_EVERFAST_PH    = {[17326294] = 17326295}, -- Vanguard_Priest
        BHUU_WJATO_THE_FIREPOOL_PH  = {[17326298] = 17326300}, -- Vanguard_Prelate
        CAA_XAZA_THE_MADPIERCER_PH  = {[17326302] = 17326304}, -- Vanguard_Visionary
        RYY_QIHI_THE_IDOLROBBER_PH  = {[17326311] = 17326313}, -- Vanguard_Liberator
        GUU_WAJI_THE_PREACHER_PH    = {[17326318] = 17326319}, -- Vanguard_Exemplar
        NEE_HUXA_THE_JUDGMENTAL_PH  = {[17326321] = 17326323}, -- Vanguard_Inciter
        SOO_JOPO_THE_FIENDKING_PH   = {[17326326] = 17326328}, -- Vanguard_Ogresoother
        XHOO_FUZA_THE_SUBLIME_PH    = {[17326334] = 17326335}, -- Vanguard_Chanter
        HEE_MIDA_THE_METICULOUS_PH  = {[17326338] = 17326340}, -- Vanguard_Salvager
        KNII_HOQO_THE_BISECTOR_PH   = {[17326343] = 17326344}, -- Vanguard_Persecutor
        KUU_XUKA_THE_NIMBLE_PH      = {[17326324] = 17326325}, -- Vanguard_Assassin
        MAA_ZAUA_THE_WYRMKEEPER_PH  = {[17326305] = 17326307}, -- Vanguard_Partisan
        PUU_TIMU_THE_PHANTASMAL_PH  = {[17326345] = 17326347}, -- Vanguard_Oracle
    },
    npc =
    {
        QM =
        {
            [17326800] =
            {
                param = {3357, 3424, 3425, 3426, 3427, 3428},
                trade =
                {
                    {item = 3357,                           mob = 17326081}, -- Angra Mainyu
                    {item = {3424, 3425, 3426, 3427, 3428}, mob = 17326098}, -- Arch Angra Mainyu
                }
            },
            [17326801] = {trade = {{item = 3396, mob = 17326093}}}, -- Taquede
            [17326802] = {trade = {{item = 3397, mob = 17326095}}}, -- Pignonpausard
            [17326803] = {trade = {{item = 3398, mob = 17326096}}}, -- Hitaume
            [17326804] = {trade = {{item = 3399, mob = 17326097}}}, -- Cavanneche
            [17326805] = {trade = {{item = 3359, mob = 17326086}}}, -- Goublefaupe
            [17326806] = {trade = {{item = 3360, mob = 17326087}}}, -- Quiebitiel
            [17326807] = {trade = {{item = 3361, mob = 17326088}}}, -- Mildaunegeux
            [17326808] = {trade = {{item = 3362, mob = 17326089}}}, -- Velosareon
            [17326809] = {trade = {{item = 3363, mob = 17326090}}}, -- Dagourmarche
        },
    },
}

return zones[xi.zone.DYNAMIS_BEAUCEDINE]
