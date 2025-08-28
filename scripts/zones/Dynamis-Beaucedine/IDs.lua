-----------------------------------
-- Area: Dynamis-Beaucedine
-----------------------------------
zones = zones or {}

zones[xi.zone.DYNAMIS_BEAUCEDINE] =
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
        CONQUEST_BASE                 = 7174, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN            = 7333, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND           = 7334, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1         = 7335, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2         = 7336, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED          = 7338, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE              = 7350, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            { minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = 17326207 },
            { minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 17326279 },
            { minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 17326353 },
            { minutes = 10, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 17326468 },
            { minutes = 20, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = { 17326742, 17326748, 17326754, 17326760, 17326765, 17326771 } },
        },

        REFILL_STATUE =
        {
            {
                { mob = 17326203, eye = xi.dynamis.eye.RED  }, -- Adamantking_Effigy
                { mob = 17326204, eye = xi.dynamis.eye.BLUE },
            },

            {
                { mob = 17326205, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 17326206, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17326275, eye = xi.dynamis.eye.RED  }, -- Serjeant_Tombstone
                { mob = 17326276, eye = xi.dynamis.eye.BLUE },
            },

            {
                { mob = 17326277, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 17326278, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17326349, eye = xi.dynamis.eye.RED  }, -- Avatar_Icon
                { mob = 17326350, eye = xi.dynamis.eye.BLUE },
            },

            {
                { mob = 17326351, eye = xi.dynamis.eye.RED   }, -- Avatar_Icon
                { mob = 17326352, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17326464, eye = xi.dynamis.eye.RED  }, -- Goblin_Replica
                { mob = 17326465, eye = xi.dynamis.eye.BLUE },
            },

            {
                { mob = 17326466, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 17326467, eye = xi.dynamis.eye.GREEN },
            },
        },

        MOLTENOX_STUBTHUMBS      = GetFirstID('Moltenox_Stubthumbs'),
        DROPRIX_GRANITEPALMS     = GetFirstID('Droprix_Granitepalms'),
        BREWNIX_BITTYPUPILS      = GetFirstID('Brewnix_Bittypupils'),
        ASCETOX_RATGUMS          = GetFirstID('Ascetox_Ratgums'),
        GIBBEROX_PIMPLEBEAK      = GetFirstID('Gibberox_Pimplebeak'),
        BORDOX_KITTYBACK         = GetFirstID('Bordox_Kittyback'),
        RUFFBIX_JUMBOLOBES       = GetFirstID('Ruffbix_Jumbolobes'),
        TOCKTIX_THINLIDS         = GetFirstID('Tocktix_Thinlids'),
        ROUTSIX_RUBBERTENDON     = GetFirstID('Routsix_Rubbertendon'),
        WHISTRIX_TOADTHROAT      = GetFirstID('Whistrix_Toadthroat'),
        SLINKIX_TRUFFLESNIFF     = GetFirstID('Slinkix_Trufflesniff'),
        SHISOX_WIDEBROW          = GetFirstID('Shisox_Widebrow'),
        SWYPESTIX_TIGERSHINS     = GetFirstID('Swypestix_Tigershins'),
        DRAKLIX_SCALECRUST       = GetFirstID('Draklix_Scalecrust'),
        MORBLOX_CHUBBYCHIN       = GetFirstID('Morblox_Chubbychin'),
        HUMEGUTTER_ADZJBADJ      = GetFirstID('Humegutter_Adzjbadj'),
        COBRACLAW_BUCHZVOTCH     = GetFirstID('Cobraclaw_Buchzvotch'),
        WRAITHDANCER_GIDBNOD     = GetFirstID('Wraithdancer_Gidbnod'),
        TARUROASTER_BIGGSJIG     = GetFirstID('Taruroaster_Biggsjig'),
        SPINALSUCKER_GALFLMALL   = GetFirstID('Spinalsucker_Galflmall'),
        LOCKBUSTER_ZAPDJIPP      = GetFirstID('Lockbuster_Zapdjipp'),
        HEAVYMAIL_DJIDZBAD       = GetFirstID('Heavymail_Djidzbad'),
        SKINMASK_UGGHFOGG        = GetFirstID('Skinmask_Ugghfogg'),
        MITHRASLAVER_DEBHABOB    = GetFirstID('Mithraslaver_Debhabob'),
        ULTRASONIC_ZEKNAJAK      = GetFirstID('Ultrasonic_Zeknajak'),
        GALKARIDER_RETZPRATZ     = GetFirstID('Galkarider_Retzpratz'),
        ELVAANLOPPER_GROKDOK     = GetFirstID('Elvaanlopper_Grokdok'),
        JEUNORAIDER_GEPKZIP      = GetFirstID('Jeunoraider_Gepkzip'),
        DRAKEFEAST_WUBMFUB       = GetFirstID('Drakefeast_Wubmfub'),
        DEATHCALLER_BIDFBID      = GetFirstID('Deathcaller_Bidfbid'),
        GUNHA_WALLSTORMER        = GetFirstID('GuNha_Wallstormer'),
        SOZHO_METALBENDER        = GetFirstID('SoZho_Metalbender'),
        GAFHO_VENOMTOUCH         = GetFirstID('GaFho_Venomtouch'),
        DEBHO_PYROHAND           = GetFirstID('DeBho_Pyrohand'),
        NAHYA_FLOODMAKER         = GetFirstID('NaHya_Floodmaker'),
        JIFHU_INFILTRATOR        = GetFirstID('JiFhu_Infiltrator'),
        MUGHA_LEGIONKILLER       = GetFirstID('MuGha_Legionkiller'),
        TAHYU_GALLANTHUNTER      = GetFirstID('TaHyu_Gallanthunter'),
        SOGHO_ADDERHANDLER       = GetFirstID('SoGho_Adderhandler'),
        NUBHI_SPIRALEYE          = GetFirstID('NuBhi_Spiraleye'),
        GUKHU_DUKESNIPER         = GetFirstID('GuKhu_Dukesniper'),
        JIKHU_TOWERCLEAVER       = GetFirstID('JiKhu_Towercleaver'),
        MIRHE_WHISPERBLADE       = GetFirstID('MiRhe_Whisperblade'),
        GOTYO_MAGENAPPER         = GetFirstID('GoTyo_Magenapper'),
        BEZHE_KEEPRAZER          = GetFirstID('BeZhe_Keeprazer'),
        FOO_PEKU_THE_BLOODCLOAK  = GetFirstID('Foo_Peku_the_Bloodcloak'),
        XAA_CHAU_THE_ROCTALON    = GetFirstID('Xaa_Chau_the_Roctalon'),
        KOO_SAXU_THE_EVERFAST    = GetFirstID('Koo_Saxu_the_Everfast'),
        BHUU_WJATO_THE_FIREPOOL  = GetFirstID('Bhuu_Wjato_the_Firepool'),
        CAA_XAZA_THE_MADPIERCER  = GetFirstID('Caa_Xaza_the_Madpiercer'),
        RYY_QIHI_THE_IDOLROBBER  = GetFirstID('Ryy_Qihi_the_Idolrobber'),
        GUU_WAJI_THE_PREACHER    = GetFirstID('Guu_Waji_the_Preacher'),
        NEE_HUXA_THE_JUDGMENTAL  = GetFirstID('Nee_Huxa_the_Judgmental'),
        SOO_JOPO_THE_FIENDKING   = GetFirstID('Soo_Jopo_the_Fiendking'),
        XHOO_FUZA_THE_SUBLIME    = GetFirstID('Xhoo_Fuza_the_Sublime'),
        HEE_MIDA_THE_METICULOUS  = GetFirstID('Hee_Mida_the_Meticulous'),
        KNII_HOQO_THE_BISECTOR   = GetFirstID('Knii_Hoqo_the_Bisector'),
        KUU_XUKA_THE_NIMBLE      = GetFirstID('Kuu_Xuka_the_Nimble'),
        MAA_ZAUA_THE_WYRMKEEPER  = GetFirstID('Maa_Zaua_the_Wyrmkeeper'),
        PUU_TIMU_THE_PHANTASMAL  = GetFirstID('Puu_Timu_the_Phantasmal'),
    },
    npc =
    {
        QM =
        {
            [17326801] =
            {
                param = { 3357, 3424, 3425, 3426, 3427, 3428 },
                trade =
                {
                    { item = 3357,                             mob = 17326081 }, -- Angra Mainyu
                    { item = { 3424, 3425, 3426, 3427, 3428 }, mob = 17326098 }, -- Arch Angra Mainyu
                }
            },

            [17326802] = { trade = { { item = 3396, mob = 17326093 } } }, -- Taquede
            [17326803] = { trade = { { item = 3397, mob = 17326095 } } }, -- Pignonpausard
            [17326804] = { trade = { { item = 3398, mob = 17326096 } } }, -- Hitaume
            [17326805] = { trade = { { item = 3399, mob = 17326097 } } }, -- Cavanneche
            [17326806] = { trade = { { item = 3359, mob = 17326086 } } }, -- Goublefaupe
            [17326807] = { trade = { { item = 3360, mob = 17326087 } } }, -- Quiebitiel
            [17326808] = { trade = { { item = 3361, mob = 17326088 } } }, -- Mildaunegeux
            [17326809] = { trade = { { item = 3362, mob = 17326089 } } }, -- Velosareon
            [17326810] = { trade = { { item = 3363, mob = 17326090 } } }, -- Dagourmarche
        },
    },
}

return zones[xi.zone.DYNAMIS_BEAUCEDINE]
