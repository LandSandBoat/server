-----------------------------------
-- Dealer Moogles & Kupon Global
-- https://www.bg-wiki.com/ffxi/Category:Mog_Bonanza
-----------------------------------
xi = xi or {}
xi.dealerMoogle = xi.dealerMoogle or {}

local debug =
{
    ENABLED     = false,    -- will disable ki consumption and print instead
    SHOWITEM    = false,    -- will display acquisition message to player if debug.ENABLED
    TO_PLAYER   = false,    -- will print debug info to player if debug.ENABLED
}

local csidLookup =
{
    [xi.zone.CHOCOBO_CIRCUIT] = { 416, 417 },
    [xi.zone.PORT_SAN_DORIA]  = { 790, 791 },
    [xi.zone.PORT_BASTOK]     = { 398, 399 },
    [xi.zone.PORT_WINDURST]   = { 856, 857 },
}

-- WARNING!!! These items cannot be customised!
-- Everything is dictacted by the client!
local kuponLookup =
{
    -- [coupon item id] = { related key item id, index of items in itemList (table below) }
    [xi.item.MOG_KUPON_A_DBCD   ] = { xi.ki.MOG_KUPON_A_DBCD,    1 },
    [xi.item.MOG_KUPON_A_DXAR   ] = { xi.ki.MOG_KUPON_A_DXAR,    2 },
    [xi.item.MOG_KUPON_AW_ABS   ] = { xi.ki.MOG_KUPON_AW_ABS,    3 },
    [xi.item.MOG_KUPON_AW_PAN   ] = { xi.ki.MOG_KUPON_AW_PAN,    4 },
    [xi.item.MOG_KUPON_A_LUM    ] = { xi.ki.MOG_KUPON_A_LUM,     5 },
    [xi.item.MOG_KUPON_W_E85    ] = { xi.ki.MOG_KUPON_W_E85,     6 },
    [xi.item.MOG_KUPON_A_RJOB   ] = { xi.ki.MOG_KUPON_A_RJOB,    7 },
    [xi.item.MOG_KUPON_W_R90    ] = { xi.ki.MOG_KUPON_W_R90,     8 },
    [xi.item.MOG_KUPON_W_M90    ] = { xi.ki.MOG_KUPON_W_M90,     9 },
    [xi.item.MOG_KUPON_W_E90    ] = { xi.ki.MOG_KUPON_W_E90,    10 },
    [xi.item.MOG_KUPON_A_E2     ] = { xi.ki.MOG_KUPON_A_E2,     11 },
    [xi.item.MOG_KUPON_I_SEAL   ] = { xi.ki.MOG_KUPON_I_SEAL,   12 },
    [xi.item.MOG_KUPON_A_DEII   ] = { xi.ki.MOG_KUPON_A_DEII,   13 },
    [xi.item.MOG_KUPON_A_DE     ] = { xi.ki.MOG_KUPON_A_DE,     14 },
    [xi.item.MOG_KUPON_A_SAL    ] = { xi.ki.MOG_KUPON_A_SAL,    15 },
    [xi.item.MOG_KUPON_A_NYZ    ] = { xi.ki.MOG_KUPON_A_NYZ,    16 },
    [xi.item.MOG_KUPON_I_S5     ] = { xi.ki.MOG_KUPON_I_S5,     17 },
    [xi.item.MOG_KUPON_I_S2     ] = { xi.ki.MOG_KUPON_I_S2,     18 },
    [xi.item.MOG_KUPON_I_ORCHE  ] = { xi.ki.MOG_KUPON_I_ORCHE,  19 },
    [xi.item.MOG_KUPON_I_AF109  ] = { xi.ki.MOG_KUPON_I_AF109,  20 },
    [xi.item.MOG_KUPON_W_EWS    ] = { xi.ki.MOG_KUPON_W_EWS,    21 },
    [xi.item.MOG_KUPON_AW_WK    ] = { xi.ki.MOG_KUPON_AW_WK,    22 },
    [xi.item.MOG_KUPON_I_S3     ] = { xi.ki.MOG_KUPON_I_S3,     23 },
    [xi.item.MOG_KUPON_A_PK109  ] = { xi.ki.MOG_KUPON_A_PK109,  24 },
    [xi.item.MOG_KUPON_I_S1     ] = { xi.ki.MOG_KUPON_I_S1,     25 },
    [xi.item.MOG_KUPON_I_SKILL  ] = { xi.ki.MOG_KUPON_I_SKILL,  26 },
    [xi.item.MOG_KUPON_I_RME    ] = { xi.ki.MOG_KUPON_I_RME,    27 },
--  [xi.item.NOT_IN_USE         ] = { xi.ki.MOG_KUPON_I,        28 },
    [xi.item.MOG_KUPON_W_JOB    ] = { xi.ki.MOG_KUPON_W_JOB,    29 },
    [xi.item.MOG_KUPON_I_MAT    ] = { xi.ki.MOG_KUPON_I_MAT,    30 },
    [xi.item.MOG_KUPON_W_DEIII  ] = { xi.ki.MOG_KUPON_W_DEIII,  31 },
    [xi.item.MOG_KUPON_AW_MIS   ] = { xi.ki.MOG_KUPON_AW_MIS,   32 },
    [xi.item.MOG_KUPON_AW_VGR   ] = { xi.ki.MOG_KUPON_AW_VGR,   33 },
    [xi.item.MOG_KUPON_AW_VGRII ] = { xi.ki.MOG_KUPON_AW_VGRII, 34 },
    [xi.item.MOG_KUPON_W_PULSE  ] = { xi.ki.MOG_KUPON_W_PULSE,  35 },
    [xi.item.MOG_KUPON_I_STONE  ] = { xi.ki.MOG_KUPON_I_STONE,  36 },
    [xi.item.MOG_KUPON_AW_GFIII ] = { xi.ki.MOG_KUPON_AW_GFIII, 37 },
    [xi.item.MOG_KUPON_AW_GFII  ] = { xi.ki.MOG_KUPON_AW_GFII,  38 },
    [xi.item.MOG_KUPON_AW_GF    ] = { xi.ki.MOG_KUPON_AW_GF,    39 },
    [xi.item.MOG_KUPON_AW_UWIII ] = { xi.ki.MOG_KUPON_AW_UWIII, 40 },
    [xi.item.MOG_KUPON_AW_UWII  ] = { xi.ki.MOG_KUPON_AW_UWII,  41 },
    [xi.item.MOG_KUPON_AW_UW    ] = { xi.ki.MOG_KUPON_AW_UW,    42 },
    [xi.item.MOG_KUPON_A_AB     ] = { xi.ki.MOG_KUPON_A_AB,     43 },
    [xi.item.MOG_KUPON_AW_COS   ] = { xi.ki.MOG_KUPON_AW_COS,   44 },
    [xi.item.MOG_KUPON_AW_KUPO  ] = { xi.ki.MOG_KUPON_AW_KUPO,  45 },
    [xi.item.MOG_KUPON_W_EMI    ] = { xi.ki.MOG_KUPON_W_EMI,    46 },
    [xi.item.MOG_KUPON_A_EMI    ] = { xi.ki.MOG_KUPON_A_EMI,    47 },
    [xi.item.MOG_KUPON_W_SRW    ] = { xi.ki.MOG_KUPON_W_SRW,    48 },
    [xi.item.MOG_KUPON_W_SCC    ] = { xi.ki.MOG_KUPON_W_SCC,    49 },
    [xi.item.MOG_KUPON_A_SYW    ] = { xi.ki.MOG_KUPON_A_SYW,    50 },
    [xi.item.MOG_KUPON_W_ASRW   ] = { xi.ki.MOG_KUPON_W_ASRW,   51 },
    [xi.item.MOG_KUPON_W_ASCC   ] = { xi.ki.MOG_KUPON_W_ASCC,   52 },
    [xi.item.MOG_KUPON_A_ASYW   ] = { xi.ki.MOG_KUPON_A_ASYW,   53 },
    [xi.item.MOG_KUPON_W_R119   ] = { xi.ki.MOG_KUPON_W_R119,   54 },
    [xi.item.MOG_KUPON_W_M119   ] = { xi.ki.MOG_KUPON_W_M119,   55 },
    [xi.item.MOG_KUPON_W_E119   ] = { xi.ki.MOG_KUPON_W_E119,   56 },
    [xi.item.MOG_KUPON_W_A119   ] = { xi.ki.MOG_KUPON_W_A119,   57 },
    [xi.item.MOG_KUPON_AW_GEIV  ] = { xi.ki.MOG_KUPON_AW_GEIV,  58 },
    [xi.item.MOG_KUPON_A_OMII   ] = { xi.ki.MOG_KUPON_A_OMII,   59 },
    [xi.item.MOG_KUPON_I_AF119  ] = { xi.ki.MOG_KUPON_I_AF119,  60 },
    [xi.item.MOG_KUPON_AW_OM    ] = { xi.ki.MOG_KUPON_AW_OM,    61 },
    [xi.item.MOG_KUPON_W_RMEA   ] = { xi.ki.MOG_KUPON_W_RMEA,   62 },
--  [xi.item.NEXT_POTENTIAL_ID  ] = { xi.ki.NEXT_POTENTIAL_ID,  63 },

}

-- WARNING!!! These items cannot be customised, and must be in the order
-- they appear in the in-game menus! Everything is dictated by the client!
local itemList =
{
    -- Kupon A-DBcd: Dynamis - Beaucedine (MOG_KUPON_A_DBCD = 2745)
    [1] =
    {
        xi.item.WARRIORS_CUISSES,
        xi.item.MELEE_CYCLAS,
        xi.item.CLERICS_BRIAULT,
        xi.item.SORCERERS_COAT,
        xi.item.DUELISTS_TABARD,
        xi.item.ASSASSINS_CULOTTES,
        xi.item.VALOR_BREECHES,
        xi.item.ABYSS_CUIRASS,
        xi.item.MONSTER_GAITERS,
        xi.item.BARDS_JUSTAUCORPS,
        xi.item.SCOUTS_SOCKS,
        xi.item.SAOTOME_DOMARU,
        xi.item.KOGA_CHAINMAIL,
        xi.item.WYRM_MAIL,
        xi.item.SUMMONERS_DOUBLET,
        xi.item.MIRAGE_JUBBAH,
        xi.item.COMMODORE_FRAC,
        xi.item.PANTIN_TOBE,
        xi.item.ETOILE_TIGHTS,
        xi.item.ARGUTE_GOWN,
    },

    -- Kupon A-DXar: Dynamis - Xarcabard (MOG_KUPON_A_DXAR = 2746)
    [2] =
    {
        xi.item.WARRIORS_LORICA,
        xi.item.MELEE_CROWN,
        xi.item.CLERICS_MITTS,
        xi.item.SORCERERS_PETASOS,
        xi.item.DUELISTS_CHAPEAU,
        xi.item.ASSASSINS_ARMLETS,
        xi.item.VALOR_SURCOAT,
        xi.item.ABYSS_BURGEONET,
        xi.item.MONSTER_GLOVES,
        xi.item.BARDS_CANNIONS,
        xi.item.SCOUTS_JERKIN,
        xi.item.SAOTOME_KABUTO,
        xi.item.KOGA_TEKKO,
        xi.item.WYRM_ARMET,
        xi.item.SUMMONERS_HORN,
        xi.item.MIRAGE_KEFFIYEH,
        xi.item.COMMODORE_TRICORNE,
        xi.item.PANTIN_TAJ,
        xi.item.ETOILE_CASAQUE,
        xi.item.ARGUTE_MORTARBOARD,
    },

    -- Kupon AW-Abs: Absolute Virtue (MOG_KUPON_AW_ABS = 2802)
    [3] =
    {
        xi.item.NINURTAS_SASH,
        xi.item.MARSS_RING,
        xi.item.BELLONAS_RING,
        xi.item.MINERVAS_RING,
        xi.item.FUTSUNO_MITAMA,
        xi.item.AUREOLE,
        xi.item.RAPHAELS_ROD,
    },

    -- Kupon AW-Pan: Pandemonium Warden (MOG_KUPON_AW_PAN = 2801)
    [4] =
    {
        xi.item.HACHIRYU_HARAMAKI,
        xi.item.NANATSUSAYA,
        xi.item.DORJE,
        xi.item.SHENLONGS_BAGHNAKHS,
    },

    -- Kupon A-Lum: Sea NM System (MOG_KUPON_A_LUM = 2736)
    [5] =
    {
        xi.item.JUSTICE_TORQUE,
        xi.item.HOPE_TORQUE,
        xi.item.PRUDENCE_TORQUE,
        xi.item.FORTITUDE_TORQUE,
        xi.item.FAITH_TORQUE,
        xi.item.TEMPERANCE_TORQUE,
        xi.item.LOVE_TORQUE,
        xi.item.MERCIFUL_CAPE,
        xi.item.ALTRUISTIC_CAPE,
        xi.item.ASTUTE_CAPE,
    },

    -- Kupon W-E85: Lv85 Empyrean Weapons (MOG_KUPON_W_E85 = 2958)
    [6] =
    {
        xi.item.VERETHRAGNA_85,
        xi.item.TWASHTAR_85,
        xi.item.ALMACE_85,
        xi.item.CALADBOLG_85,
        xi.item.FARSHA_85,
        xi.item.UKONVASARA_85,
        xi.item.REDEMPTION_85,
        xi.item.RHONGOMIANT_85,
        xi.item.KANNAGI_85,
        xi.item.MASAMUNE_85,
        xi.item.GAMBANTEINN_85,
        xi.item.HVERGELMIR_85,
        xi.item.GANDIVA_85,
        xi.item.ARMAGEDDON_85,
    },

    -- Kupon A-RJob: Lv70 Relic Armor Accessories (MOG_KUPON_A_RJOB = 2959)
    [7] =
    {
        xi.item.WARRIORS_STONE,
        xi.item.MELEE_CAPE,
        xi.item.CLERICS_BELT,
        xi.item.SORCERERS_BELT,
        xi.item.DUELISTS_BELT,
        xi.item.ASSASSINS_CAPE,
        xi.item.VALOR_CAPE,
        xi.item.ABYSS_CAPE,
        xi.item.MONSTER_BELT,
        xi.item.BARDS_CAPE,
        xi.item.SCOUTS_BELT,
        xi.item.SAOTOME_KOSHI_ATE,
        xi.item.KOGA_SARASHI,
        xi.item.WYRM_BELT,
        xi.item.SUMMONERS_CAPE,
        xi.item.MIRAGE_MANTLE,
        xi.item.COMMODORE_BELT,
        xi.item.PANTIN_CAPE,
        xi.item.ETOILE_CAPE,
        xi.item.ARGUTE_BELT,
    },

    -- Kupon W-R90: Lv90 Relic Weapons and upgrade materials (MOG_KUPON_W_R90 = 3438)
    [8] =
    {
        { xi.item.AEGIS_90,            { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }                           },
        { xi.item.GJALLARHORN_90,      { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }                           },
        { xi.item.SPHARAI_90,          { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.MANDAU_90,           { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.EXCALIBUR_90,        { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.RAGNAROK_90,         { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.GUTTLER_90,          { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.BRAVURA_90,          { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.GUNGNIR_90,          { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.APOCALYPSE_90,       { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.KIKOKU_90,           { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.AMANOMURAKUMO_90,    { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.MJOLLNIR_90,         { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.CLAUSTRUM_90,        { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.ANNIHILATOR_90,      { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
        { xi.item.YOICHINOYUMI_90,     { xi.item.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.item.PLUTON, 300 } },
    },

    -- Kupon W-M90: Lv90 Mythic Weapons (MOG_KUPON_W_M90 = 3439)
    [9] =
    {
        { xi.item.CONQUEROR_90,        { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.GLANZFAUST_90,       { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.YAGRUSH_90,          { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.LAEVATEINN_90,       { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.MURGLEIS_90,         { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.VAJRA_90,            { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.BURTGANG_90,         { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.LIBERATOR_90,        { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.AYMUR_90,            { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.CARNWENHAN_90,       { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.GASTRAPHETES_90,     { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.KOGARASUMARU_90,     { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.NAGI_90,             { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.RYUNOHIGE_90,        { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.NIRVANA_90,          { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.TIZONA_90,           { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.DEATH_PENALTY_90,    { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.KENKONKEN_90,        { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.TERPSICHORE_90,      { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
        { xi.item.TUPSIMATI_90,        { xi.item.MULCIBARS_SCORIA, 3 }, { xi.item.BEITETSU, 300 } },
    },

    -- Kupon W-E90: Lv90 Empyrean Weapons (MOG_KUPON_W_E90 = 3440)
    [10] =
    {
        { xi.item.VERETHRAGNA_90,  xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTCINDER, 60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.TWASHTAR_90,     xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTDROSS,  60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.ALMACE_90,       xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTCINDER, 60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.CALADBOLG_90,    xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTDROSS,  60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.FARSHA_90,       xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTCINDER, 60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.UKONVASARA_90,   xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTDROSS,  60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.REDEMPTION_90,   xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTCINDER, 60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.RHONGOMIANT_90,  xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTCINDER, 60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.KANNAGI_90,      xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTDROSS,  60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.MASAMUNE_90,     xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTCINDER, 60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.GAMBANTEINN_90,  xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTDROSS,  60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.HVERGELMIR_90,   xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTDROSS,  60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.GANDIVA_90,      xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTCINDER, 60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.ARMAGEDDON_90,   xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTDROSS,  60 }, { xi.item.RIFTBORN_BOULDER, 300 } },
        { xi.item.DAURDABLA_90,    xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTCINDER, 60 },                                    },
        { xi.item.OCHAIN_90,       xi.item.DENSE_CLUSTER, { xi.item.PINCH_OF_RIFTDROSS,  60 },                                    },
    },

    -- Kupon A-E+2: Empyrean Armor +2 (MOG_KUPON_A_E2 = 3441)
    [11] =
    {
        { xi.item.RAVAGERS_MASK_P2,        xi.item.RAVAGERS_LORICA_P2,    xi.item.RAVAGERS_MUFFLERS_P2,      xi.item.RAVAGERS_CUISSES_P2,   xi.item.RAVAGERS_CALLIGAE_P2   },
        { xi.item.TANTRA_CROWN_P2,         xi.item.TANTRA_CYCLAS_P2,      xi.item.TANTRA_GLOVES_P2,          xi.item.TANTRA_HOSE_P2,        xi.item.TANTRA_GAITERS_P2      },
        { xi.item.ORISON_CAP_P2,           xi.item.ORISON_BLIAUD_P2,      xi.item.ORISON_MITTS_P2,           xi.item.ORISON_PANTALOONS_P2,  xi.item.ORISON_DUCKBILLS_P2    },
        { xi.item.GOETIA_PETASOS_P2,       xi.item.GOETIA_COAT_P2,        xi.item.GOETIA_GLOVES_P2,          xi.item.GOETIA_CHAUSSES_P2,    xi.item.GOETIA_SABOTS_P2       },
        { xi.item.ESTOQUEURS_CHAPPEL_P2,   xi.item.ESTOQUEURS_SAYON_P2,   xi.item.ESTOQUEURS_GANTHEROTS_P2,  xi.item.ESTOQUEURS_FUSEAU_P2,  xi.item.ESTOQUEURS_HOUSEAUX_P2 },
        { xi.item.RAIDERS_BONNET_P2,       xi.item.RAIDERS_VEST_P2,       xi.item.RAIDERS_ARMLETS_P2,        xi.item.RAIDERS_CULOTTES_P2,   xi.item.RAIDERS_POULAINES_P2   },
        { xi.item.CREED_ARMET_P2,          xi.item.CREED_CUIRASS_P2,      xi.item.CREED_GAUNTLETS_P2,        xi.item.CREED_CUISSES_P2,      xi.item.CREED_SABATONS_P2      },
        { xi.item.BALE_BURGEONET_P2,       xi.item.BALE_CUIRASS_P2,       xi.item.BALE_GAUNTLETS_P2,         xi.item.BALE_FLANCHARD_P2,     xi.item.BALE_SOLLERETS_P2      },
        { xi.item.FERINE_CABASSET_P2,      xi.item.FERINE_GAUSAPE_P2,     xi.item.FERINE_MANOPLAS_P2,        xi.item.FERINE_QUIJOTES_P2,    xi.item.FERINE_OCREAE_P2       },
        { xi.item.AOIDOS_CALOT_P2,         xi.item.AOIDOS_HONGRELINE_P2,  xi.item.AOIDOS_MANCHETTES_P2,      xi.item.AOIDOS_RHINGRAVE_P2,   xi.item.AOIDOS_COTHURNES_P2    },
        { xi.item.SYLVAN_GAPETTE_P2,       xi.item.SYLVAN_CABAN_P2,       xi.item.SYLVAN_GLOVELETTES_P2,     xi.item.SYLVAN_BRAGUES_P2,     xi.item.SYLVAN_BOTTILLONS_P2   },
        { xi.item.UNKAI_KABUTO_P2,         xi.item.UNKAI_DOMARU_P2,       xi.item.UNKAI_KOTE_P2,             xi.item.UNKAI_HAIDATE_P2,      xi.item.UNKAI_SUNE_ATE_P2      },
        { xi.item.IGA_ZUKIN_P2,            xi.item.IGA_NINGI_P2,          xi.item.IGA_TEKKO_P2,              xi.item.IGA_HAKAMA_P2,         xi.item.IGA_KYAHAN_P2          },
        { xi.item.LANCERS_MEZAIL_P2,       xi.item.LANCERS_PLACKART_P2,   xi.item.LANCERS_VAMBRACES_P2,      xi.item.LANCERS_CUISSOTS_P2,   xi.item.LANCERS_SCHYNBALDS_P2  },
        { xi.item.CALLERS_HORN_P2,         xi.item.CALLERS_DOUBLET_P2,    xi.item.CALLERS_BRACERS_P2,        xi.item.CALLERS_SPATS_P2,      xi.item.CALLERS_PIGACHES_P2    },
        { xi.item.MAVI_KAVUK_P2,           xi.item.MAVI_MINTAN_P2,        xi.item.MAVI_BAZUBANDS_P2,         xi.item.MAVI_TAYT_P2,          xi.item.MAVI_BASMAK_P2         },
        { xi.item.NAVARCHS_TRICORNE_P2,    xi.item.NAVARCHS_FRAC_P2,      xi.item.NAVARCHS_GANTS_P2,         xi.item.NAVARCHS_CULOTTES_P2,  xi.item.NAVARCHS_BOTTES_P2     },
        { xi.item.CIRQUE_CAPPELLO_P2,      xi.item.CIRQUE_FARSETTO_P2,    xi.item.CIRQUE_GUANTI_P2,          xi.item.CIRQUE_PANTALONI_P2,   xi.item.CIRQUE_SCARPE_P2       },
        { xi.item.CHARIS_TIARA_P2,         xi.item.CHARIS_CASAQUE_P2,     xi.item.CHARIS_BANGLES_P2,         xi.item.CHARIS_TIGHTS_P2,      xi.item.CHARIS_TOE_SHOES_P2    },
        { xi.item.SAVANTS_BONNET_P2,       xi.item.SAVANTS_GOWN_P2,       xi.item.SAVANTS_BRACERS_P2,        xi.item.SAVANTS_PANTS_P2,      xi.item.SAVANTS_LOAFERS_P2     },
    },
    -- Kupon I-Seal: 10 (Body) or 8 (other) of any One Empyrean Armor upgrade seals (MOG_KUPON_I_SEAL = 3442)
    [12] =
    {-- List 12 uses submenus and requires different table formatting to address each { itemid, qty } pairing. Item = List[12][Job][Slot]
        { { xi.item.RAVAGERS_SEAL_HEAD,   8 }, { xi.item.RAVAGERS_SEAL_BODY,   10 }, { xi.item.RAVAGERS_SEAL_HANDS,   8 }, { xi.item.RAVAGERS_SEAL_LEGS,   8 }, { xi.item.RAVAGERS_SEAL_FEET,   8 } },
        { { xi.item.TANTRA_SEAL_HEAD,     8 }, { xi.item.TANTRA_SEAL_BODY,     10 }, { xi.item.TANTRA_SEAL_HANDS,     8 }, { xi.item.TANTRA_SEAL_LEGS,     8 }, { xi.item.TANTRA_SEAL_FEET,     8 } },
        { { xi.item.ORISON_SEAL_HEAD,     8 }, { xi.item.ORISON_SEAL_BODY,     10 }, { xi.item.ORISON_SEAL_HANDS,     8 }, { xi.item.ORISON_SEAL_LEGS,     8 }, { xi.item.ORISON_SEAL_FEET,     8 } },
        { { xi.item.GOETIA_SEAL_HEAD,     8 }, { xi.item.GOETIA_SEAL_BODY,     10 }, { xi.item.GOETIA_SEAL_HANDS,     8 }, { xi.item.GOETIA_SEAL_LEGS,     8 }, { xi.item.GOETIA_SEAL_FEET,     8 } },
        { { xi.item.ESTOQUEURS_SEAL_HEAD, 8 }, { xi.item.ESTOQUEURS_SEAL_BODY, 10 }, { xi.item.ESTOQUEURS_SEAL_HANDS, 8 }, { xi.item.ESTOQUEURS_SEAL_LEGS, 8 }, { xi.item.ESTOQUEURS_SEAL_FEET, 8 } },
        { { xi.item.RAIDERS_SEAL_HEAD,    8 }, { xi.item.RAIDERS_SEAL_BODY,    10 }, { xi.item.RAIDERS_SEAL_HANDS,    8 }, { xi.item.RAIDERS_SEAL_LEGS,    8 }, { xi.item.RAIDERS_SEAL_FEET,    8 } },
        { { xi.item.CREED_SEAL_HEAD,      8 }, { xi.item.CREED_SEAL_BODY,      10 }, { xi.item.CREED_SEAL_HANDS,      8 }, { xi.item.CREED_SEAL_LEGS,      8 }, { xi.item.CREED_SEAL_FEET,      8 } },
        { { xi.item.BALE_SEAL_HEAD,       8 }, { xi.item.BALE_SEAL_BODY,       10 }, { xi.item.BALE_SEAL_HANDS,       8 }, { xi.item.BALE_SEAL_LEGS,       8 }, { xi.item.BALE_SEAL_FEET,       8 } },
        { { xi.item.FERINE_SEAL_HEAD,     8 }, { xi.item.FERINE_SEAL_BODY,     10 }, { xi.item.FERINE_SEAL_HANDS,     8 }, { xi.item.FERINE_SEAL_LEGS,     8 }, { xi.item.FERINE_SEAL_FEET,     8 } },
        { { xi.item.AOIDOS_SEAL_HEAD,     8 }, { xi.item.AOIDOS_SEAL_BODY,     10 }, { xi.item.AOIDOS_SEAL_HANDS,     8 }, { xi.item.AOIDOS_SEAL_LEGS,     8 }, { xi.item.AOIDOS_SEAL_FEET,     8 } },
        { { xi.item.SYLVAN_SEAL_HEAD,     8 }, { xi.item.SYLVAN_SEAL_BODY,     10 }, { xi.item.SYLVAN_SEAL_HANDS,     8 }, { xi.item.SYLVAN_SEAL_LEGS,     8 }, { xi.item.SYLVAN_SEAL_FEET,     8 } },
        { { xi.item.UNKAI_SEAL_HEAD,      8 }, { xi.item.UNKAI_SEAL_BODY,      10 }, { xi.item.UNKAI_SEAL_HANDS,      8 }, { xi.item.UNKAI_SEAL_LEGS,      8 }, { xi.item.UNKAI_SEAL_FEET,      8 } },
        { { xi.item.IGA_SEAL_HEAD,        8 }, { xi.item.IGA_SEAL_BODY,        10 }, { xi.item.IGA_SEAL_HANDS,        8 }, { xi.item.IGA_SEAL_LEGS,        8 }, { xi.item.IGA_SEAL_FEET,        8 } },
        { { xi.item.LANCERS_SEAL_HEAD,    8 }, { xi.item.LANCERS_SEAL_BODY,    10 }, { xi.item.LANCERS_SEAL_HANDS,    8 }, { xi.item.LANCERS_SEAL_LEGS,    8 }, { xi.item.LANCERS_SEAL_FEET,    8 } },
        { { xi.item.CALLERS_SEAL_HEAD,    8 }, { xi.item.CALLERS_SEAL_BODY,    10 }, { xi.item.CALLERS_SEAL_HANDS,    8 }, { xi.item.CALLERS_SEAL_LEGS,    8 }, { xi.item.CALLERS_SEAL_FEET,    8 } },
        { { xi.item.MAVI_SEAL_HEAD,       8 }, { xi.item.MAVI_SEAL_BODY,       10 }, { xi.item.MAVI_SEAL_HANDS,       8 }, { xi.item.MAVI_SEAL_LEGS,       8 }, { xi.item.MAVI_SEAL_FEET,       8 } },
        { { xi.item.NAVARCHS_SEAL_HEAD,   8 }, { xi.item.NAVARCHS_SEAL_BODY,   10 }, { xi.item.NAVARCHS_SEAL_HANDS,   8 }, { xi.item.NAVARCHS_SEAL_LEGS,   8 }, { xi.item.NAVARCHS_SEAL_FEET,   8 } },
        { { xi.item.CIRQUE_SEAL_HEAD,     8 }, { xi.item.CIRQUE_SEAL_BODY,     10 }, { xi.item.CIRQUE_SEAL_HANDS,     8 }, { xi.item.CIRQUE_SEAL_LEGS,     8 }, { xi.item.CIRQUE_SEAL_FEET,     8 } },
        { { xi.item.CHARIS_SEAL_HEAD,     8 }, { xi.item.CHARIS_SEAL_BODY,     10 }, { xi.item.CHARIS_SEAL_HANDS,     8 }, { xi.item.CHARIS_SEAL_LEGS,     8 }, { xi.item.CHARIS_SEAL_FEET,     8 } },
        { { xi.item.SAVANTS_SEAL_HEAD,    8 }, { xi.item.SAVANTS_SEAL_BODY,    10 }, { xi.item.SAVANTS_SEAL_HANDS,    8 }, { xi.item.SAVANTS_SEAL_LEGS,    8 }, { xi.item.SAVANTS_SEAL_FEET,    8 } },
    },
    -- Kupon A-DeII: Delve boss armor pieces (MOG_KUPON_A_DEII = 3967)
    [13] =
    {
        xi.item.YAOYOTL_HELM,
        xi.item.YAOYOTL_GLOVES,
        xi.item.WHIRLPOOL_MASK,
        xi.item.WHIRLPOOL_GREAVES,
        xi.item.NAHTIRAH_HAT,
        xi.item.NAHTIRAH_TROUSERS,
        xi.item.UMBANI_CAP,
        xi.item.UMBANI_BOOTS,
        xi.item.UMUTHI_HAT,
        xi.item.UMUTHI_GLOVES,
        xi.item.IGHWA_CAP,
        xi.item.IGHWA_TROUSERS,
    },

    -- Kupon A-De: Delve field armor pieces (MOG_KUPON_A_DE = 3968)
    [14] =
    {
        { xi.item.MIKINAAK_HELM,           { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.MIKINAAK_BREASTPLATE,    { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.MIKINAAK_GAUNTLETS,      { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.MIKINAAK_CUISSES,        { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.MIKINAAK_GREAVES,        { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.MANIBOZHO_BERET,         { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.MANIBOZHO_JERKIN,        { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.MANIBOZHO_GLOVES,        { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.MANIBOZHO_BRAIS,         { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.MANIBOZHO_BOOTS,         { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.BOKWUS_CIRCLET,          { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.BOKWUS_ROBE,             { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.BOKWUS_GLOVES,           { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.BOKWUS_SLOPS,            { xi.item.AIRLIXIR_P2, 3 } },
        { xi.item.BOKWUS_BOOTS,            { xi.item.AIRLIXIR_P2, 3 } },
    },

    -- Kupon A-Sal: Salvage II (MOG_KUPON_A_SAL = 3969)
    [15] =
    {
        xi.item.ARES_MASK_P1,
        xi.item.ARES_CUIRASS_P1,
        xi.item.ARES_GAUNTLETS_P1,
        xi.item.ARES_FLANCHARD_P1,
        xi.item.ARES_SOLLERETS_P1,
        xi.item.SKADIS_VISOR_P1,
        xi.item.SKADIS_CUIRIE_P1,
        xi.item.SKADIS_BAZUBANDS_P1,
        xi.item.SKADIS_CHAUSSES_P1,
        xi.item.SKADIS_JAMBEAUX_P1,
        xi.item.USUKANE_SOMEN_P1,
        xi.item.USUKANE_HARAMAKI_P1,
        xi.item.USUKANE_GOTE_P1,
        xi.item.USUKANE_HIZAYOROI_P1,
        xi.item.USUKANE_SUNE_ATE_P1,
        xi.item.MARDUKS_TIARA_P1,
        xi.item.MARDUKS_JUBBAH_P1,
        xi.item.MARDUKS_DASTANAS_P1,
        xi.item.MARDUKS_SHALWAR_P1,
        xi.item.MARDUKS_CRACKOWS_P1,
        xi.item.MORRIGANS_CORONAL_P1,
        xi.item.MORRIGANS_ROBE_P1,
        xi.item.MORRIGANS_CUFFS_P1,
        xi.item.MORRIGANS_SLOPS_P1,
        xi.item.MORRIGANS_PIGACHES_P1,
    },

    -- Kupon A-Nyz: Nyzul Isle Uncharted Area Survey (MOG_KUPON_A_NYZ = 3970)
    [16] =
    {
        xi.item.PHORCYS_SALADE,
        xi.item.PHORCYS_KORAZIN,
        xi.item.PHORCYS_MITTS,
        xi.item.PHORCYS_DIRS,
        xi.item.PHORCYS_SCHUHS,
        xi.item.THAUMAS_HAT,
        xi.item.THAUMAS_COAT,
        xi.item.THAUMAS_GLOVES,
        xi.item.THAUMAS_KECKS,
        xi.item.THAUMAS_NAILS,
        xi.item.NARES_CAP,
        xi.item.NARES_SAIO,
        xi.item.NARES_CUFFS,
        xi.item.NARES_TREWS,
        xi.item.NARES_CLOGS,
    },
    -- Kupon I-S5: Skirmish Rank V Simulacrum Segments (MOG_KUPON_I_S5 = 3971)
    [17] =
    {
        xi.item.RALA_VISAGE_V,
        xi.item.CIRDAS_VISAGE_V,
        xi.item.FAITHFULS_TORSO_V,
        xi.item.PAIR_OF_FAITHFULS_LEGS_V,
        xi.item.YORCIA_VISAGE_V,
        xi.item.RAKAZNAR_VISGE_V,
    },

    -- Kupon I-S2: Skirmish Rank II Simulacrum Segments (MOG_KUPON_I_S2 = 3972)
    [18] =
    {
        xi.item.RALA_VISAGE_II,
        xi.item.CIRDAS_VISAGE_II,
        xi.item.FAITHFULS_TORSO_II,
        xi.item.PAIR_OF_FAITHFULS_LEGS_II,
        xi.item.YORCIA_VISAGE_II,
        xi.item.RAKAZNAR_VISGE_II,
    },

    -- Kupon I-Orche: Orchestrion music (MOG_KUPON_I_ORCHE = 3973)
    [19] =
    {
        xi.keyItem.SHEET_OF_E_ADOULINIAN_TUNES,
        xi.keyItem.SHEET_OF_W_ADOULINIAN_TUNES,
        xi.keyItem.SHEET_OF_ZILART_TUNES,
        xi.keyItem.SHEET_OF_CONFLICT_TUNES,
    },
    -- Kupon I-AF109: 12 of each REM's Tale Chapters 1-10 (MOG_KUPON_I_AF109 = 8729)
    [20] =
    {
        {
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_1,  12 },
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_2,  12 },
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_3,  12 },
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_4,  12 },
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_5,  12 },
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_6,  12 },
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_7,  12 },
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_8,  12 },
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_9,  12 },
            { xi.item.COPY_OF_REMS_TALE_CHAPTER_10, 12 },
        },
    },

    -- Kupon W-EWS: Walk of Echoes Weapons (MOG_KUPON_W_EWS = 8730)
    [21] =
    {
        xi.item.DUMUZIS,
        xi.item.KHANDORMA,
        xi.item.BRUNELLO,
        xi.item.XIPHIAS,
        xi.item.SACRIPANTE,
        xi.item.SHAMASH,
        xi.item.UMILIATI,
        xi.item.DABOYA,
        xi.item.KASASAGI,
        xi.item.TORIGASHIRANOTACHI,
        xi.item.ROSE_COUVERTE,
        xi.item.PAIKEA,
        xi.item.CIRCINAE,
        xi.item.MOLLFRITH,
    },
    -- Kupon AW-WK: Weapon or Armor from Wildskeeper Reives (MOG_KUPON_AW_WK = 8731)
    [22] =
    {
        -- Colkhab
        {
            xi.item.PHAWAYLLA_EARRING,
            xi.item.IK_CAPE,
            xi.item.HUANI_COLLAR,
            xi.item.KUKU_STONE,
            xi.item.HATXIIK,
            xi.item.KUAKUAKAIT,
            xi.item.KAABNAX_HAT,
            xi.item.KAABNAX_TROUSERS,
            xi.item.TAIKOGANE,
        },
        -- Tchakka
        {
            xi.item.ATZINTLI_NECKLACE,
            xi.item.TUILHA_CAPE,
            xi.item.KALBORON_STONE,
            xi.item.CHOJ_BAND,
            xi.item.ATOYAC,
            xi.item.AZUKINAGAMITSU,
            xi.item.ATETEPEYORG,
            xi.item.EJEKAMAL_MASK,
            xi.item.EJEKAMAL_BOOTS,
        },
        -- Achuka
        {
            xi.item.CUAMIZ_COLLAR,
            xi.item.BUQUWIK_CAPE,
            xi.item.AQREQAQ_BOMBLET,
            xi.item.ACHAQ_GRIP,
            xi.item.MAOCHINOLI,
            xi.item.XIUTLEATO,
            xi.item.OTOMI_HELM,
            xi.item.OTOMI_GLOVES,
        },
        -- Hurkan
        {
            xi.item.HUNAHPU,
            xi.item.XBALANQUE,
            xi.item.TZACAB_GRIP,
            xi.item.ANIMIKII_BULLET,
            xi.item.KAQULJAAN,
            xi.item.UKUXKAJ_CAP,
            xi.item.UKUXKAJ_BOOTS,
            xi.item.JUKUKIK_FEATHER,
            xi.item.KAYAPA_CAPE,
            xi.item.PAQICHIKAJI_RING,
            xi.item.JAQIJ_SASH,
        },
        -- Yumcax
        {
            xi.item.IXTAB,
            xi.item.TAMAXCHI,
            xi.item.BUREMTE_HAT,
            xi.item.BUREMTE_GLOVES,
            xi.item.PAHTLI_CAPE,
            xi.item.OCACHI_GORGET,
            xi.item.KUNAJI_RING,
            xi.item.IXIMULEW_CAPE,
            xi.item.CHUQABA_BELT,
            xi.item.QUANPUR_NECKLACE,
            xi.item.BARATARIA_RING,
        },
        -- Kumhau
        {
            xi.item.TORO_CAPE,
            xi.item.FRIOMISI_EARRING,
            xi.item.TLAMIZTLI_COLLAR,
            xi.item.CETL_BELT,
            xi.item.AJJUB_BOW,
            xi.item.BAQIL_STAFF,
            xi.item.QUIAHUIZ_HELM,
            xi.item.QUIAHUIZ_TROUSERS,
            xi.item.NEPOTE_BELL,
        },
    },

    -- Kupon I-S3: Skirmish Rank III Simulacrum Segments (MOG_KUPON_I_S3 = 8732)
    [23] =
    {
        xi.item.RALA_VISAGE_III,
        xi.item.CIRDAS_VISAGE_III,
        xi.item.FAITHFULS_TORSO_III,
        xi.item.PAIR_OF_FAITHFULS_LEGS_III,
        xi.item.YORCIA_VISAGE_III,
        xi.item.RAKAZNAR_VISGE_III,
    },

    -- Kupon A-PK109: iLevel 109 Peacekeeper Coalition Armor (MOG_KUPON_A_PK109 = 8733)
    [24] =
    {
        xi.item.KARIEYH_MORION_P1,
        xi.item.KARIEYH_HAUBERT_P1,
        xi.item.KARIEYH_MOUFLES_P1,
        xi.item.KARIEYH_BRAYETTES_P1,
        xi.item.KARIEYH_SOLLERETS_P1,
        xi.item.THURANDAUT_CHAPEAU_P1,
        xi.item.THURANDAUT_TABARD_P1,
        xi.item.THURANDAUT_GLOVES_P1,
        xi.item.THURANDAUT_TIGHTS_P1,
        xi.item.THURANDAUT_BOOTS_P1,
        xi.item.ORVAIL_CORONA_P1,
        xi.item.ORVAIL_ROBE_P1,
        xi.item.ORVAIL_CUFFS_P1,
        xi.item.ORVAIL_PANTS_P1,
        xi.item.ORVAIL_SOULIERS_P1,
    },

    -- Kupon I-S1: Skirmish Rank I Simulacrum Segments (MOG_KUPON_I_S1 = 8734)
    [25] =
    {
        xi.item.RALA_VISAGE_I,
        xi.item.CIRDAS_VISAGE_I,
        xi.item.FAITHFULS_TORSO_I,
        xi.item.PAIR_OF_FAITHFULS_LEGS_I,
        xi.item.YORCIA_VISAGE_I,
        xi.item.RAKAZNAR_VISGE_I,
    },

    -- Kupon I-Skill: Skill books (MOG_KUPON_I_SKILL = 8735)
    [26] =
    {
        -- Combat
        {
            xi.item.COPY_OF_MIKHES_MEMO,
            xi.item.DAGGER_ENCHIRIDION,
            xi.item.COPY_OF_SWING_AND_STAB,
            xi.item.COPY_OF_MIEUSELOIRS_DIARY,
            xi.item.COPY_OF_STRIKING_BULLS_DIARY,
            xi.item.COPY_OF_DEATH_FOR_DIMWITS,
            xi.item.COPY_OF_LUDWIGS_REPORT,
            xi.item.COPY_OF_CLASH_OF_TITANS,
            xi.item.COPY_OF_KAGETORAS_DIARY,
            xi.item.COPY_OF_NOILLURIES_LOG,
            xi.item.COPY_OF_FERREOUSS_DIARY,
            xi.item.COPY_OF_KAYEEL_PAYEELS_MEMOIRS,
            xi.item.COPY_OF_PERIHS_PRIMER,
            xi.item.COPY_OF_BARRELS_OF_FUN,
            xi.item.THROWING_WEAPON_ENCHIRIDION,
            xi.item.COPY_OF_MIKHES_NOTE,
            xi.item.COPY_OF_SONIAS_DIARY,
            xi.item.COPY_OF_THE_SUCCESSOR,
            xi.item.COPY_OF_KATETORAS_JOURNAL,
        },
        -- Magic
        {
            xi.item.COPY_OF_ALTANAS_HYMN,
            xi.item.COPY_OF_COVEFFE_BARROWS_MUSINGS,
            xi.item.COPY_OF_AID_FOR_ALL,
            xi.item.INVESTIGATIVE_REPORT,
            xi.item.BOUNTY_LIST,
            xi.item.COPY_OF_DARK_DEEDS,
            xi.item.COPY_OF_BREEZY_LIBRETTO,
            xi.item.CAVERNOUS_SCORE,
            xi.item.BEAMING_SCORE,
            xi.item.COPY_OF_YOMIS_DIAGRAM,
            xi.item.COPY_OF_ASTRAL_HOMELAND,
            xi.item.COPY_OF_LIFE_FORM_STUDY,
            xi.item.COPY_OF_HROHJS_RECORD,
            xi.item.COPY_OF_THE_BELL_TOLLS,
        },
    },

    -- Kupon I-RME: RME Upgrade Materials x300 (MOG_KUPON_I_RME = 8738)
    [27] =
    {
        { { xi.item.PLUTON,            300 } },
        { { xi.item.BEITETSU,          300 } },
        { { xi.item.RIFTBORN_BOULDER,  300 } },
    },

    -- 28: blank menu

    -- Kupon W-Job: JSE Oboro Weapons (MOG_KUPON_W_JOB = 8793)
    [29] =
    {
        xi.item.MINOS,
        xi.item.NYEPEL,
        xi.item.SINDRI,
        xi.item.KALADANDA,
        xi.item.EGEKING,
        xi.item.SANDUNG,
        xi.item.PRIWEN,
        xi.item.CRONUS,
        xi.item.ARKTOI,
        xi.item.TERPANDER,
        xi.item.LIONSQUALL,
        xi.item.KURIKARANOTACHI,
        xi.item.SHIGI,
        xi.item.AREADBHAR,
        xi.item.GRIDARVOR,
        xi.item.MIMESIS,
        xi.item.DEATHLOCKE,
        xi.item.OHTAS,
        xi.item.POLYHYMNIA,
        xi.item.COEUS,
        xi.item.DUNNA,
        xi.item.AETTIR,
    },
    -- Kupon I-Mat: One type of special material (MOG_KUPON_I_MAT = 8794)
    [30] =
    {
        xi.item.BZTAVIAN_STINGER,
        xi.item.BZTAVIAN_WING,
        xi.item.ROCKFIN_TOOTH,
        xi.item.ROCKFIN_FIN,
        xi.item.GABBRATH_HORN,
        xi.item.SLICE_OF_GABBRATH_MEAT,
        xi.item.WAKTZA_ROSTRUM,
        xi.item.WAKTZA_CREST,
        xi.item.YGGDREANT_BOLE,
        xi.item.YGGDREANT_ROOT,
        xi.item.CEHUETZI_CLAW,
        xi.item.CEHUETZI_PELT,
        xi.item.CEHUETZI_ICE_SHARD,
        xi.item.SCARLETITE_INGOT,
        xi.item.ORMOLU_INGOT,
        xi.item.VOIDWROUGHT_PLATE,
        xi.item.KAGGENS_CUTICLE,
        xi.item.AKVANS_PENNON,
        xi.item.SUIT_OF_HAHAVAS_MAIL,
        xi.item.PILS_TUILLIE,
        xi.item.CELAENOS_CLOTH,
    },

    -- Kupon W-DeIII: Delve boss weapons (MOG_KUPON_DEIII = 8795)
    [31] =
    {
        xi.item.OATIXUR,
        xi.item.KEREHCATL,
        xi.item.UPUKIREX,
        xi.item.IZHIIKOH,
        xi.item.TSURUMARU,
        xi.item.ILLAPA,
        xi.item.BURAMENKAH,
        xi.item.UKUDYONI,
        xi.item.IZIZOEKSI,
        xi.item.TAJABIT,
        xi.item.QALGWER,
        xi.item.BOLELABUNGA,
        xi.item.NGQOQWANB,
        xi.item.FALUBEZA,
        xi.item.JUSHIMATSU,
    },

    -- Kupon AW-Mis: Equipment or a weapon from High-Tier Mission Battlefields (MOG_KUPON_AW_MIS = 8796)
    [32] =
    {
            -- Ark Angel 1
        {
            xi.item.LITHELIMB_CAP,
            xi.item.BLOODRAIN_STRAP,
            xi.item.ANAHERA_SABER,
            xi.item.CASTIGATION,
            xi.item.MANABYSS_PIGACHES,
        },
            -- Ark Angel 2
        {
            xi.item.ANAHERA_SCYTHE,
            xi.item.FRAVASHI_MANTLE,
            xi.item.VENABULUM,
            xi.item.SCAMPS_SOLLERETS,
            xi.item.THEURGISTS_SLACKS,
        },
            -- Ark Angel 3
        {
            xi.item.SEKHMET_CORSET,
            xi.item.REGIMEN_MITTENS,
            xi.item.FELISTRIS_MASK,
            xi.item.RAIMITSUKANE,
            xi.item.ANAHERA_TABAR,
        },
            -- Ark Angel 4
        {
            xi.item.CAGLIOSTROS_ROD,
            xi.item.ANAHERA_SWORD,
            xi.item.PATRICIUS_RING,
            xi.item.DYNASTY_MITTS,
            xi.item.OSMIUM_CUISSES,
        },
            -- Ark Angel 5
        {
            xi.item.AGITATORS_COLLAR,
            xi.item.DAIHANSHI_HABAKI,
            xi.item.TUNGLMYRKVI,
            xi.item.LURID_MITTS,
            xi.item.ANAHERA_BLADE,
        },
            -- Pentacide Perpetrator
        {
            xi.item.KYUJUTSUGI,
            xi.item.LENTUS_GRIP,
            xi.item.NONE, -- Gap slot 3
            xi.item.NONE, -- Gap slot 4
            xi.item.TRUX_EARRING,
            xi.item.SANARE_EARRING,
            xi.item.GELAI_EARRING,
            xi.item.CREMATIO_EARRING,
            xi.item.TRIPUDIO_EARRING,
        },
            -- Return to Delkfutt's Tower
        {
            xi.item.MESYOHI_HAUBERGEON,
            xi.item.MESYOHI_SLACKS,
            xi.item.MESYOHI_SWORD,
            xi.item.MESYOHI_ROD,
        },
            -- The Celestial Nexus
        {
            xi.item.VANIR_GUN,
            xi.item.VANIR_KNIFE,
            xi.item.VANIR_COTEHARDIE,
            xi.item.VANIR_BATTERY,
            xi.item.VANIR_BOOTS,
        },
            -- The Savage
        {
            xi.item.ISCHEMIA_CHASUBLE,
            xi.item.SCUFFLERS_COSCIALES,
            xi.item.HEGIRA_WRISTBANDS,
            xi.item.METALSINGER_BELT,
            xi.item.DOMESTICATORS_EARRING,
        },
            -- The Warriors Path
        {
            xi.item.HANGAKU_NO_YUMI,
            xi.item.SUKEROKU_HACHIMAKI,
            xi.item.BATTLECAST_GAITERS,
            xi.item.GINSEN,
            xi.item.MIZUKAGE_NO_KUBIKAZARI,
        },
            -- Puppet In Peril
        {
            xi.item.SAVAS_JAWSHAN,
            xi.item.SIFAHIR_SLACKS,
            xi.item.SAHIP_HELM,
            xi.item.BESTAS_BANE,
            xi.item.PRATIK_EARRING,
        },
            -- Legacy of the Lost
        {
            xi.item.PTICA_HEADGEAR,
            xi.item.KARMESIN_VEST,
            xi.item.KANDZA_CRACKOWS,
            xi.item.TENGU_NO_HANE,
            xi.item.TENGU_NO_OBI,
        },
            -- Rank Five Missions
        {
            xi.item.LIGHTREAVER,
            xi.item.DREAD_JUPON,
            xi.item.ONIMUSHA_NO_KOTE,
            xi.item.PERDITION_SLOPS,
            xi.item.TREPIDITY_MANTLE,
        },
            -- Head Wind
        {
            xi.item.DURGAI_LEGGINGS,
            xi.item.CHIDORI,
            xi.item.BAGHERE_SALADE,
            xi.item.SHETAL_STONE,
            xi.item.NILGAL_POLE,
        },
            -- Trial By Fire
        {
            xi.item.ATAKIGIRI,
            xi.item.COALRAKE_SABOTS,
            xi.item.PERFERVID_SWORD,
            xi.item.IMMOLATION_GRIP,
            xi.item.ANNEALED_MANTLE,
        },
            -- Trial By Ice
        {
            xi.item.FRAZIL_STAFF,
            xi.item.FLOESTONE,
            xi.item.CALVED_CLAWS,
            xi.item.NILAS_GLOVES,
            xi.item.RIMEICE_EARRING,
        },
            -- Trial By Wind
        {
            xi.item.LEVANTE_DAGGER,
            xi.item.PONENTE_SASH,
            xi.item.LEBECHE_RING,
            xi.item.TRAMONTANE_AXE,
            xi.item.OSTRO_GREAVES,
        },
            -- Trial By Earth
        {
            xi.item.MAFIC_CUDGEL,
            xi.item.SUPERSHEAR_RING,
            xi.item.TOGAKUSHI_SHURIKEN_POUCH,
            xi.item.FORESHOCK_SWORD,
            xi.item.PLUMOSE_SACHET,
        },
            -- Trial By Lightning
        {
            xi.item.STACCATO_STAFF,
            xi.item.DONAR_GUN,
            xi.item.UKKO_SASH,
            xi.item.VOLTSURGE_TORQUE,
            xi.item.BRONTES_CUISSES,
        },
            -- Trial By Water
        {
            xi.item.PHREATIC_AXE,
            xi.item.PELAGOS_LANCE,
            xi.item.VADOSE_ROD,
            xi.item.BENTHOS_GRIP,
            xi.item.NERITIC_EARRING,
        },
            -- The Moonlit Path
        {
            xi.item.MEDEINA_KILIJ,
            xi.item.CAPITOLINE_STRAP,
            xi.item.MAIITSOH_HAUBE,
            xi.item.VRIKODARA_JUPON,
            xi.item.LUPINE_CAPE,
        },
            -- Waking the Beast
        {
            xi.item.MARQUETRY_STAFF,
            xi.item.LAPIDARY_TUNIC,
            xi.item.DIAMANTAIRE_SOLLERETS,
            xi.item.SATLADA_NECKLACE,
            xi.item.ENGRAVED_BELT,
        },
            -- Waking Dreams
        {
            xi.item.SHUHANSADAMUNE,
            xi.item.CHOZORON_COSELETE,
            xi.item.LOAGAETH_CUFFS,
            xi.item.DARKSIDE_EARRING,
            xi.item.PERNICIOUS_RING,
        },
            -- One to Be Feared
        {
            xi.item.DENOUEMENTS,
            xi.item.TERMINAL_HELM,
            xi.item.TERMINAL_PLATE,
            xi.item.CONSUMMATION_TORQUE,
            xi.item.CULMINUS,
            xi.item.CESSANCE_EARRING,
        },
            -- Dawn
        {
            xi.item.GYVE_DOUBLET,
            xi.item.FETTERING_BLADE,
            xi.item.VENERY_BOW,
            xi.item.LATRIA_SASH,
            xi.item.GYVE_TROUSERS,
            xi.item.LAIC_MANTLE,
        },
            -- Other
        {
            xi.item.DIVINATOR,
            xi.item.DIVINATOR_II,
            xi.item.SERAPHICALLER,
        },
    },

    -- Kupon AW-Vgr: Equipment from Vagary Notorious Monsters Perfiden and Plouton (MOG_KUPON_AW_VGR = 9087)
    [33] =
    {
            -- Perfidien
        {
            xi.item.COUNTS_GARB,
            xi.item.COUNTS_CUFFS,
            xi.item.ETIOLATION_EARRING,
            xi.item.ENERVATING_EARRING,
        },
            -- Plouton
        {
            xi.item.TARTARUS_PLATEMAIL,
            xi.item.BEFOULED_CROWN,
            xi.item.ODIUM,
            xi.item.INCARNATION_SASH,
        }
    },

    -- Kupon AW-VgrII: Equipment from Vagary NMs Palloritus, Putraxia and Rancibus (MOG_KUPON_AW_VGRII = 9088)
    [34] =
    {
            -- Palloritus
        {
            xi.item.ACHIUCHIKAPU,
            xi.item.RHADAMANTHUS,
            xi.item.PUNCHINELLOS,
            xi.item.DEFIANT_COLLAR,
        },
            -- Putraxia
        {
            xi.item.SOULCLEAVER,
            xi.item.ACCLIMATOR,
            xi.item.CRUSHERS_GAUNTLETS,
            xi.item.RUMINATION_SASH,
        },
            -- Rancibus
        {
            xi.item.MIASMIC_PANTS,
            xi.item.CRYPTIC_EARRING,
            xi.item.MINDMELTER,
            xi.item.DEVIVIFIER,
        },
    },
    -- Mog Kupon W-Pulse: Pulse weapons (MOG_KUPON_W_PULSE = 9089)
    [35] =
    {
        xi.item.GIRRU,
        xi.item.CORUSCANTI,
        xi.item.ASTERIA,
        xi.item.GUSTERION,
        xi.item.SAGASINGER,
        xi.item.EPHEMERON,
        xi.item.BOREALIS,
        xi.item.AYTANRI,
        xi.item.HIMTHIGE,
        xi.item.DELPHINIUS,
        xi.item.ADFLICTIO,
        xi.item.IKARIGIRI,
        xi.item.MURASAMEMARU,
        xi.item.TENKOMARU,
        xi.item.DUKKHA,
    },

    -- Kupon I-Stone: Skirmish Stones +2 (MOG_KUPON_I_STONE = 9090)
    [36] =
    {
        { { xi.item.VERDIGRIS_STONE_P2,          12 } },
        { { xi.item.GHASTLY_STONE_P2,            12 } },
        { { xi.item.WAILING_STONE_P2,            12 } },
        { { xi.item.SNOWSLIT_STONE_P2,           12 } },
        { { xi.item.SNOWTIP_STONE_P2,            12 } },
        { { xi.item.SNOWDIM_STONE_P2,            12 } },
        { { xi.item.SNOWORB_STONE_P2,            12 } },
        { { xi.item.LEAFSLIT_STONE_P2,           12 } },
        { { xi.item.LEAFTIP_STONE_P2,            12 } },
        { { xi.item.LEAFDIM_STONE_P2,            12 } },
        { { xi.item.LEAFORB_STONE_P2,            12 } },
        { { xi.item.DUSKSLIT_STONE_P2,           12 } },
        { { xi.item.DUSKTIP_STONE_P2,            12 } },
        { { xi.item.DUSKDIM_STONE_P2,            12 } },
        { { xi.item.DUSKORB_STONE_P2,            12 } },
        { { xi.item.FRAYED_SACK_OF_FECUNDITY,    12 } },
        { { xi.item.FRAYED_SACK_OF_PLENTY,       12 } },
        { { xi.item.FRAYED_SACK_OF_OPULENCE,     12 } },
    },
    -- Kupon AW-GFIII: Geas Fete (Content Level 119+) (MOG_KUPON_AW_GFIII = 9175)
    [37] =
    {
            -- HAND-TO-HAND WEAPONS
        {
            xi.item.NIBIRU_SAINTI,
            xi.item.CHASTISERS,
            xi.item.HAMMERFISTS,
            xi.item.MIDNIGHTS,
            xi.item.ESHUS,
            xi.item.CONDEMNERS,
        },
            -- DAGGERS
        {
            xi.item.NIBIRU_KNIFE,
            xi.item.ENCHUFLA,
            xi.item.SHIJO,
            xi.item.KALI,
            xi.item.SKINFLAYER,
            xi.item.SANGOMA,
        },
            -- SWORDS
        {
            xi.item.NIBIRU_BLADE,
            xi.item.NIXXER,
            xi.item.EMISSARY,
            xi.item.IRIS,
            xi.item.COLADA,
            xi.item.NONE, -- Gap slot 6
            xi.item.DEACON_SABER,
            xi.item.DEACON_SWORD,
            xi.item.KOBOTO,
            xi.item.REIKIKO,
        },
            -- GREAT SWORDS
        {
            xi.item.NIBIRU_FAUSSAR,
            xi.item.BIDENHANDER,
            xi.item.ZULFIQAR,
        },
            -- AXES
        {
            xi.item.NIBIRU_TABAR,
            xi.item.SKULLRENDER,
            xi.item.DIGIRBALAG,
            xi.item.NONE, -- Gap slot 4
            xi.item.DEACON_TABAR,
        },
            -- GREAT AXES
        {
            xi.item.NIBIRU_CHOPPER,
            xi.item.ROUTER,
            xi.item.INSTIGATOR,
            xi.item.AGANOSHE,
            xi.item.NONE, -- Gap slot 5
            xi.item.REIKIONO,
            xi.item.JOKUSHUONO,
        },
            -- POLEARMS
        {
            xi.item.NIBIRU_LANCE,
            xi.item.ANNEALED_LANCE,
            xi.item.RHOMPHAIA,
            xi.item.REIENKYO,
            xi.item.NONE, -- Gap slot 5
            xi.item.HABILE_MAZRAK,
        },
            -- SCYTHES
        {
            xi.item.NIBIRU_SICKLE,
            xi.item.DEATHBANE,
            xi.item.OBSCHINE,
            xi.item.MISANTHROPY,
            xi.item.DACNOMANIA,
            xi.item.DEACON_SCYTHE,
            xi.item.SHUKUYUS_SCYTHE,
        },
            -- KATANAS
        {
            xi.item.MIJIN,
            xi.item.AIZUSHINTOGO,
            xi.item.KANARIA,
        },
            -- GREAT KATANAS
        {
            xi.item.SENSUI,
            xi.item.ICHIGOHITOFURI,
            xi.item.UMARU,
            xi.item.NONE, -- Gap slot 4
            xi.item.DEACON_BLADE,
        },
            -- CLUBS
        {
            xi.item.NIBIRU_CUDGEL,
            xi.item.QUELLER_ROD,
            xi.item.SOLSTICE,
            xi.item.SUCELLUS,
            xi.item.GADA,
        },
            -- STAVES
        {
            xi.item.NIBIRU_STAFF,
            xi.item.ESPIRITUS,
            xi.item.AKADEMOS,
            xi.item.LATHI,
            xi.item.GRIOAVOLR,
            xi.item.NONE, -- Gap slot 6
            xi.item.NONE, -- Gap slot 7
            xi.item.REIKIKON,
        },
            -- THROWING WEAPONS
        {
            xi.item.SERAPHIC_AMPULLA,
            xi.item.GRENADE_CORE,
            xi.item.SAPIENCE_ORB,
            xi.item.FALCON_EYE,
            xi.item.ALBIN_BANE,
            xi.item.AMAR_CLUSTER,
            xi.item.HYDROCERA,
            xi.item.MANTOPTERA_EYE,
            xi.item.EXPEDITIOUS_PINION,
            xi.item.PEMPHREDO_TATHLUM,
            xi.item.ELIS_TOME,
        },
            -- BOWS
        {
            xi.item.NIBIRU_BOW,
            xi.item.VIJAYA_BOW,
            xi.item.TELLER,
        },
            -- GUNS
        {
            xi.item.NIBIRU_GUN,
            xi.item.COMPENSATOR,
            xi.item.NONE, -- Gap slot 3
            xi.item.HOLLIDAY,
            xi.item.MOLYBDOSIS,
        },
            -- SHIELDS
        {
            xi.item.NIBIRU_SHIELD,
            xi.item.GENMEI_SHIELD,
        },
            -- INSTRUMENTS
        {
            xi.item.NIBIRU_HARP,
        },
            -- GRIPS
        {
            xi.item.CLEMENCY_GRIP,
            xi.item.WILLPOWER_GRIP,
            xi.item.FOREFATHERS_GRIP,
            xi.item.GIUOCO_GRIP,
            xi.item.BALARAMA_GRIP,
            xi.item.NIOBID_STRAP,
            xi.item.POTENT_GRIP,
            xi.item.THRACE_STRAP,
            xi.item.ALBER_STRAP,
        },
            -- HEADGEAR
        {
            xi.item.ESCHITE_HELM,
            xi.item.PSYCLOTH_TIARA,
            xi.item.RAWHIDE_MASK,
            xi.item.DESPAIR_HELM,
            xi.item.VANYA_HOOD,
            xi.item.PURSUERS_BERET,
            xi.item.NAGA_SOMEN,
            xi.item.SKORMOTH_MASK,
            xi.item.ODYSSEAN_HELM,
            xi.item.VALOROUS_MASK,
            xi.item.HERCULEAN_HELM,
            xi.item.MERLINIC_HOOD,
            xi.item.CHIRONIC_HAT,
            xi.item.NONE, -- Gap slot 14
            xi.item.NONE, -- Gap slot 15
            xi.item.GENMEI_KABUTO,
        },
            -- CHEST ARMOR
        {
            xi.item.ESCHITE_BREASTPLATE,
            xi.item.PSYCLOTH_VEST,
            xi.item.RAWHIDE_VEST,
            xi.item.DESPAIR_MAIL,
            xi.item.VANYA_ROBE,
            xi.item.PURSUERS_DOUBLET,
            xi.item.NAGA_SAMUE,
            xi.item.SWELLERS_HARNESS,
            xi.item.ONCA_SUIT,
            xi.item.KUBIRA_MEIKOGAI,
            xi.item.ANNOINTED_KALASIRIS,
            xi.item.MAKORA_MEIKOGAI,
            xi.item.ENFORCERS_HARNESS,
            xi.item.UAC_JERKIN,
            xi.item.SHANGO_ROBE,
            xi.item.ABNOBA_KAFTAN,
            xi.item.ODYSSEAN_CHESTPLATE,
            xi.item.VALOROUS_MAIL,
            xi.item.HERCULEAN_VEST,
            xi.item.MERLINIC_JUBBAH,
            xi.item.CHIRONIC_DOUBLET,
            xi.item.NONE, -- Gap slot 22
            xi.item.NONE, -- Gap slot 23
            xi.item.NONE, -- Gap slot 24
            xi.item.ZENDIK_ROBE,
            xi.item.REIKI_OSODE,
        },
            -- GLOVES AND GAUNTLETS
        {
            xi.item.NAGA_TEKKO,
            xi.item.ESCHITE_GAUNTLETS,
            xi.item.PSYCLOTH_MANILLAS,
            xi.item.RAWHIDE_GLOVES,
            xi.item.DESPAIR_FINGER_GLOVES,
            xi.item.VANYA_CUFFS,
            xi.item.PURSUERS_CUFFS,
            xi.item.SHRIEKERS_CUFFS,
            xi.item.KURYS_GLOVES,
            xi.item.ODYSSEAN_GAUNTLETS,
            xi.item.VALOROUS_MITTS,
            xi.item.HERCULEAN_GLOVES,
            xi.item.MERLINIC_DASTANAS,
            xi.item.CHIRONIC_GLOVES,
            xi.item.COMPOSERS_MITTS,
            xi.item.NONE, -- Gap slot 16
            xi.item.NONE, -- Gap slot 17
            xi.item.KOBO_KOTE,
        },
            -- LEG ARMOR
        {
            xi.item.NAGA_HAKAMA,
            xi.item.ESCHITE_CUISSES,
            xi.item.PSYCLOTH_LAPPAS,
            xi.item.RAWHIDE_TROUSERS,
            xi.item.DESPAIR_CUISSES,
            xi.item.VANYA_SLOPS,
            xi.item.PURSUERS_PANTS,
            xi.item.DOYEN_PANTS,
            xi.item.OBATALA_SUBLIGAR,
            xi.item.SELVANS_SUBLIGAR,
            xi.item.ODYSSEAN_CUISSES,
            xi.item.VALOROUS_HOSE,
            xi.item.HERCULEAN_TROUSERS,
            xi.item.MERLINIC_SHALWAR,
            xi.item.CHIRONIC_HOSE,
            xi.item.NONE, -- Gap slot 16
            xi.item.JOKUSHU_HAIDATE,
        },
            -- BOOTS AND GREAVES
        {
            xi.item.PURSUERS_GAITERS,
            xi.item.NAGA_KYAHAN,
            xi.item.ESCHITE_GREAVES,
            xi.item.PSYCLOTH_BOOTS,
            xi.item.RAWHIDE_BOOTS,
            xi.item.DESPAIR_GREAVES,
            xi.item.VANYA_CLOGS,
            xi.item.INSPIRITED_BOOTS,
            xi.item.TUTYR_SABOTS,
            xi.item.ODYSSEAN_GREAVES,
            xi.item.VALOROUS_GREAVES,
            xi.item.HERCULEAN_BOOTS,
            xi.item.MERLINIC_CRACKOWS,
            xi.item.CHIRONIC_SLIPPERS,
            xi.item.COMPOSERS_SABOTS,
            xi.item.NONE, -- Gap slot 16
            xi.item.NONE, -- Gap slot 17
            xi.item.NONE, -- Gap slot 18
            xi.item.SHUKUYU_SUNE_ATE,
        },
            -- NECK PIECES
        {
            xi.item.MARKED_GORGET,
            xi.item.SUBTLETY_SPECTACLES,
            xi.item.DAMPENERS_TORQUE,
            xi.item.EMPATH_NECKLACE,
            xi.item.RETI_PENDANT,
            xi.item.DIEMER_GORGET,
            xi.item.CARO_NECKLACE,
            xi.item.NODENS_GORGET,
            xi.item.CLOTHARIUS_TORQUE,
            xi.item.DEINO_COLLAR,
            xi.item.HOMERIC_GORGET,
            xi.item.AINIA_COLLAR,
            xi.item.JOKUSHU_CHAIN,
        },
            -- EARRINGS
        {
            xi.item.MENDICANTS_EARRING,
            xi.item.INFUSED_EARRING,
            xi.item.CALAMITOUS_EARRING,
            xi.item.HERMETIC_EARRING,
            xi.item.HALASZ_EARRING,
            xi.item.ASSUAGE_EARRING,
            xi.item.ISHVARA_EARRING,
            xi.item.EVANS_EARRING,
            xi.item.LEMPO_EARRING,
            xi.item.THUREOUS_EARRING,
            xi.item.DIGNITARYS_EARRING,
            xi.item.TELOS_EARRING,
            xi.item.GENMEI_EARRING,
        },
            -- BELTS AND SASHES
        {
            xi.item.LUCIDITY_SASH,
            xi.item.SINEW_BELT,
            xi.item.ESCHAN_STONE,
            xi.item.GRUNFELD_ROPE,
            xi.item.POROUS_ROPE,
            xi.item.SULLA_BELT,
            xi.item.YEMAYA_BELT,
            xi.item.CHANNELERS_STONE,
            xi.item.ASKLEPIAN_BELT,
            xi.item.SARISSAPHOROI_BELT,
            xi.item.LUMINARY_SASH,
            xi.item.KERYGMA_BELT,
            xi.item.REIKI_YOTAI,
            xi.item.KOBO_OBI,
        },
            -- RINGS
        {
            xi.item.OVERBEARING_RING,
            xi.item.RESONANCE_RING,
            xi.item.PURITY_RING,
            xi.item.WARDENS_RING,
            xi.item.PETROV_RING,
            xi.item.FORTIFIED_RING,
            xi.item.VERTIGO_RING,
            xi.item.EVANESCENCE_RING,
            xi.item.BEGRUDGING_RING,
            xi.item.APATE_RING,
            xi.item.PERSIS_RING,
            xi.item.HETAIROI_RING,
            xi.item.SHUKUYU_RING,
            xi.item.RAHAB_RING,
        },
            -- CAPES AND CLOAKS
        {
            xi.item.DISPERSERS_CAPE,
            xi.item.THAUMATURGES_CAPE,
            xi.item.PENETRATING_CAPE,
            xi.item.PHILIDOR_MANTLE,
            xi.item.SOKOLSKI_MANTLE,
            xi.item.QUARREL_MANTLE,
            xi.item.XUCAU_MANTLE,
            xi.item.TANTALIC_CAPE,
            xi.item.SCINTILLATING_CAPE,
            xi.item.PHALANGITE_MANTLE,
            xi.item.PERIMEDE_CAPE,
            xi.item.AGEMA_CAPE,
            xi.item.ENUMA_MANTLE,
            xi.item.REIKI_CLOAK,
        },
            -- OTHER
        {
            xi.item.SEKI_SHURIKEN_POUCH,
        },
    },

    -- Kupon AW-GFII: Geas Fete (MOG_KUPN_AW_GWII = 9176)
    [38] =
    {
            -- HAND-TO-HAND WEAPONS
        {
            xi.item.NIBIRU_SAINTI,
            xi.item.CHASTISERS,
            xi.item.HAMMERFISTS,
            xi.item.MIDNIGHTS,
            xi.item.ESHUS,
            xi.item.CONDEMNERS,
        },
            -- DAGGERS
        {
            xi.item.NIBIRU_KNIFE,
            xi.item.ENCHUFLA,
            xi.item.SHIJO,
            xi.item.KALI,
            xi.item.SKINFLAYER,
        },
            -- SWORDS
        {
            xi.item.NIBIRU_BLADE,
            xi.item.NIXXER,
            xi.item.EMISSARY,
            xi.item.IRIS,
            xi.item.COLADA,
        },
            -- GREAT SWORDS
        {
            xi.item.NIBIRU_FAUSSAR,
            xi.item.BIDENHANDER,
            xi.item.ZULFIQAR,
        },
            -- AXES
        {
            xi.item.NIBIRU_TABAR,
            xi.item.SKULLRENDER,
            xi.item.DIGIRBALAG,
        },
            -- GREAT AXES
        {
            xi.item.NIBIRU_CHOPPER,
            xi.item.ROUTER,
            xi.item.INSTIGATOR,
            xi.item.AGANOSHE,
        },
            -- POLEARMS
        {
            xi.item.NIBIRU_LANCE,
            xi.item.ANNEALED_LANCE,
            xi.item.RHOMPHAIA,
            xi.item.REIENKYO,
        },
            -- SCYTHES
        {
            xi.item.NIBIRU_SICKLE,
            xi.item.DEATHBANE,
            xi.item.OBSCHINE,
        },
            -- KATANAS
        {
            xi.item.MIJIN,
            xi.item.AIZUSHINTOGO,
            xi.item.KANARIA,
        },
            -- GREAT KATANAS
        {
            xi.item.SENSUI,
            xi.item.ICHIGOHITOFURI,
            xi.item.UMARU,
        },
            -- CLUBS
        {
            xi.item.NIBIRU_CUDGEL,
            xi.item.QUELLER_ROD,
            xi.item.SOLSTICE,
            xi.item.SUCELLUS,
            xi.item.GADA,
        },
            -- STAVES
        {
            xi.item.NIBIRU_STAFF,
            xi.item.ESPIRITUS,
            xi.item.AKADEMOS,
            xi.item.LATHI,
            xi.item.GRIOAVOLR,
        },
            -- THROWING WEAPONS
        {
            xi.item.SERAPHIC_AMPULLA,
            xi.item.GRENADE_CORE,
            xi.item.SAPIENCE_ORB,
            xi.item.FALCON_EYE,
            xi.item.ALBIN_BANE,
            xi.item.AMAR_CLUSTER,
            xi.item.HYDROCERA,
            xi.item.MANTOPTERA_EYE,
            xi.item.EXPEDITIOUS_PINION,
            xi.item.PEMPHREDO_TATHLUM,
        },
            -- BOWS
        {
            xi.item.NIBIRU_BOW,
            xi.item.VIJAYA_BOW,
            xi.item.TELLER,
        },
            -- GUNS
        {
            xi.item.NIBIRU_GUN,
            xi.item.COMPENSATOR,
            xi.item.NONE, -- Gap slot 3
            xi.item.HOLLIDAY,
        },
            -- SHIELDS
        {
            xi.item.NIBIRU_SHIELD,
        },
            -- INSTRUMENTS
        {
            xi.item.NIBIRU_HARP,
        },
            -- GRIPS
        {
            xi.item.CLEMENCY_GRIP,
            xi.item.WILLPOWER_GRIP,
            xi.item.FOREFATHERS_GRIP,
            xi.item.GIUOCO_GRIP,
            xi.item.BALARAMA_GRIP,
            xi.item.NIOBID_STRAP,
            xi.item.POTENT_GRIP,
        },
            -- HEADGEAR
        {
            xi.item.ESCHITE_HELM,
            xi.item.PSYCLOTH_TIARA,
            xi.item.RAWHIDE_MASK,
            xi.item.DESPAIR_HELM,
            xi.item.VANYA_HOOD,
            xi.item.PURSUERS_BERET,
            xi.item.NAGA_SOMEN,
            xi.item.SKORMOTH_MASK,
            xi.item.ODYSSEAN_HELM,
            xi.item.VALOROUS_MASK,
            xi.item.HERCULEAN_HELM,
            xi.item.MERLINIC_HOOD,
            xi.item.CHIRONIC_HAT,
        },
            -- CHEST ARMOR
        {
            xi.item.ESCHITE_BREASTPLATE,
            xi.item.PSYCLOTH_VEST,
            xi.item.RAWHIDE_VEST,
            xi.item.DESPAIR_MAIL,
            xi.item.VANYA_ROBE,
            xi.item.PURSUERS_DOUBLET,
            xi.item.NAGA_SAMUE,
            xi.item.SWELLERS_HARNESS,
            xi.item.ONCA_SUIT,
            xi.item.KUBIRA_MEIKOGAI,
            xi.item.ANNOINTED_KALASIRIS,
            xi.item.MAKORA_MEIKOGAI,
            xi.item.ENFORCERS_HARNESS,
            xi.item.UAC_JERKIN,
            xi.item.SHANGO_ROBE,
            xi.item.ABNOBA_KAFTAN,
        },
            -- GLOVES AND GAUNTLETS
        {
            xi.item.NAGA_TEKKO,
            xi.item.ESCHITE_GAUNTLETS,
            xi.item.PSYCLOTH_MANILLAS,
            xi.item.RAWHIDE_GLOVES,
            xi.item.DESPAIR_FINGER_GLOVES,
            xi.item.VANYA_CUFFS,
            xi.item.PURSUERS_CUFFS,
            xi.item.SHRIEKERS_CUFFS,
            xi.item.KURYS_GLOVES,
            xi.item.ODYSSEAN_GAUNTLETS,
            xi.item.VALOROUS_MITTS,
            xi.item.HERCULEAN_GLOVES,
            xi.item.MERLINIC_DASTANAS,
            xi.item.CHIRONIC_GLOVES,
        },
            -- LEG ARMOR
        {
            xi.item.NAGA_HAKAMA,
            xi.item.ESCHITE_CUISSES,
            xi.item.PSYCLOTH_LAPPAS,
            xi.item.RAWHIDE_TROUSERS,
            xi.item.DESPAIR_CUISSES,
            xi.item.VANYA_SLOPS,
            xi.item.PURSUERS_PANTS,
            xi.item.DOYEN_PANTS,
            xi.item.OBATALA_SUBLIGAR,
            xi.item.SELVANS_SUBLIGAR,
            xi.item.ODYSSEAN_CUISSES,
            xi.item.VALOROUS_HOSE,
            xi.item.HERCULEAN_TROUSERS,
            xi.item.MERLINIC_SHALWAR,
            xi.item.CHIRONIC_HOSE,
        },
            -- BOOTS AND GREAVES
        {
            xi.item.PURSUERS_GAITERS,
            xi.item.NAGA_KYAHAN,
            xi.item.ESCHITE_GREAVES,
            xi.item.PSYCLOTH_BOOTS,
            xi.item.RAWHIDE_BOOTS,
            xi.item.DESPAIR_GREAVES,
            xi.item.VANYA_CLOGS,
            xi.item.INSPIRITED_BOOTS,
            xi.item.TUTYR_SABOTS,
            xi.item.ODYSSEAN_GREAVES,
            xi.item.VALOROUS_GREAVES,
            xi.item.HERCULEAN_BOOTS,
            xi.item.MERLINIC_CRACKOWS,
            xi.item.CHIRONIC_SLIPPERS,
        },
            -- NECK PIECES
        {
            xi.item.MARKED_GORGET,
            xi.item.SUBTLETY_SPECTACLES,
            xi.item.DAMPENERS_TORQUE,
            xi.item.EMPATH_NECKLACE,
            xi.item.RETI_PENDANT,
            xi.item.DIEMER_GORGET,
            xi.item.CARO_NECKLACE,
            xi.item.NODENS_GORGET,
            xi.item.CLOTHARIUS_TORQUE,
            xi.item.DEINO_COLLAR,
            xi.item.HOMERIC_GORGET,
        },
            -- EARRINGS
        {
            xi.item.MENDICANTS_EARRING,
            xi.item.INFUSED_EARRING,
            xi.item.CALAMITOUS_EARRING,
            xi.item.HERMETIC_EARRING,
            xi.item.HALASZ_EARRING,
            xi.item.ASSUAGE_EARRING,
            xi.item.ISHVARA_EARRING,
            xi.item.EVANS_EARRING,
            xi.item.LEMPO_EARRING,
            xi.item.THUREOUS_EARRING,
            xi.item.DIGNITARYS_EARRING,
        },
            -- BELTS AND SASHES
        {
            xi.item.LUCIDITY_SASH,
            xi.item.SINEW_BELT,
            xi.item.ESCHAN_STONE,
            xi.item.GRUNFELD_ROPE,
            xi.item.POROUS_ROPE,
            xi.item.SULLA_BELT,
            xi.item.YEMAYA_BELT,
            xi.item.CHANNELERS_STONE,
            xi.item.ASKLEPIAN_BELT,
            xi.item.SARISSAPHOROI_BELT,
        },
            -- RINGS
        {
            xi.item.OVERBEARING_RING,
            xi.item.RESONANCE_RING,
            xi.item.PURITY_RING,
            xi.item.WARDENS_RING,
            xi.item.PETROV_RING,
            xi.item.FORTIFIED_RING,
            xi.item.VERTIGO_RING,
            xi.item.EVANESCENCE_RING,
            xi.item.BEGRUDGING_RING,
            xi.item.APATE_RING,
            xi.item.PERSIS_RING,
        },
            -- CAPES AND CLOAKS
        {
            xi.item.DISPERSERS_CAPE,
            xi.item.THAUMATURGES_CAPE,
            xi.item.PENETRATING_CAPE,
            xi.item.PHILIDOR_MANTLE,
            xi.item.SOKOLSKI_MANTLE,
            xi.item.QUARREL_MANTLE,
            xi.item.XUCAU_MANTLE,
            xi.item.TANTALIC_CAPE,
            xi.item.SCINTILLATING_CAPE,
            xi.item.PHALANGITE_MANTLE,
        },
    },

    -- Kupon AW-GF: Geas Fete (Content Level 119) (MOG_KUPON_AW_GF = 9177)
    [39] =
    {
        { --[[ Null Menu 01 --]] },
        { --[[ Null Menu 02 --]] },
        { --[[ Null Menu 03 --]] },
        { --[[ Null Menu 04 --]] },
        { --[[ Null Menu 05 --]] },
        { --[[ Null Menu 06 --]] },
        { --[[ Null Menu 07 --]] },
        { --[[ Null Menu 08 --]] },
        { --[[ Null Menu 09 --]] },
        { --[[ Null Menu 10 --]] },
        { --[[ Null Menu 11 --]] },
        { --[[ Null Menu 12 --]] },

            -- THROWING WEAPONS
        {
            xi.item.GRENADE_CORE,
            xi.item.SERAPHIC_AMPULLA,
            xi.item.ALBIN_BANE,
            xi.item.AMAR_CLUSTER,
            xi.item.HYDROCERA,
            xi.item.MANTOPTERA_EYE,
        },

        { --[[ Null Menu 14 --]] },
        { --[[ Null Menu 15 --]] },
        { --[[ Null Menu 16 --]] },
        { --[[ Null Menu 17 --]] },

            -- GRIPS
        {
            xi.item.WILLPOWER_GRIP,
            xi.item.CLEMENCY_GRIP,
            xi.item.GIUOCO_GRIP,
            xi.item.BALARAMA_GRIP,
        },
            -- HEADGEAR
        {
            xi.item.ESCHITE_HELM,
            xi.item.VANYA_HOOD,
            xi.item.PSYCLOTH_TIARA,
            xi.item.DESPAIR_HELM,
            xi.item.PURSUERS_BERET,
            xi.item.RAWHIDE_MASK,
            xi.item.NAGA_SOMEN,
        },
            -- CHEST ARMOR
        {
            xi.item.VANYA_ROBE,
            xi.item.ESCHITE_BREASTPLATE,
            xi.item.PSYCLOTH_VEST,
            xi.item.DESPAIR_MAIL,
            xi.item.PURSUERS_DOUBLET,
            xi.item.RAWHIDE_VEST,
            xi.item.NAGA_SAMUE,
        },
            -- GLOVES AND GAUNTLETS
        {
            xi.item.VANYA_CUFFS,
            xi.item.ESCHITE_GAUNTLETS,
            xi.item.PSYCLOTH_MANILLAS,
            xi.item.DESPAIR_FINGER_GLOVES,
            xi.item.PURSUERS_CUFFS,
            xi.item.RAWHIDE_GLOVES,
            xi.item.NAGA_TEKKO,
        },
            -- LEG ARMOR
        {
            xi.item.VANYA_SLOPS,
            xi.item.ESCHITE_CUISSES,
            xi.item.PSYCLOTH_LAPPAS,
            xi.item.DESPAIR_CUISSES,
            xi.item.PURSUERS_PANTS,
            xi.item.RAWHIDE_TROUSERS,
            xi.item.NAGA_HAKAMA,
        },
            -- BOOTS AND GREAVES
        {
            xi.item.VANYA_CLOGS,
            xi.item.ESCHITE_GREAVES,
            xi.item.PSYCLOTH_BOOTS,
            xi.item.DESPAIR_GREAVES,
            xi.item.PURSUERS_GAITERS,
            xi.item.RAWHIDE_BOOTS,
            xi.item.NAGA_KYAHAN,
        },
            -- NECK PIECES
        {
            xi.item.SUBTLETY_SPECTACLES,
            xi.item.MARKED_GORGET,
            xi.item.RETI_PENDANT,
            xi.item.DIEMER_GORGET,
            xi.item.CARO_NECKLACE,
            xi.item.NODENS_GORGET,
        },
            -- EARRINGS
        {
            xi.item.INFUSED_EARRING,
            xi.item.MENDICANTS_EARRING,
            xi.item.HALASZ_EARRING,
            xi.item.ASSUAGE_EARRING,
            xi.item.ISHVARA_EARRING,
            xi.item.EVANS_EARRING,
        },
            -- BELTS AND SASHES
        {
            xi.item.LUCIDITY_SASH,
            xi.item.GRUNFELD_ROPE,
            xi.item.POROUS_ROPE,
            xi.item.SULLA_BELT,
        },
            -- RINGS
        {
            xi.item.OVERBEARING_RING,
            xi.item.RESONANCE_RING,
            xi.item.PETROV_RING,
            xi.item.FORTIFIED_RING,
            xi.item.VERTIGO_RING,
            xi.item.EVANESCENCE_RING,
        },
            -- CAPES AND CLOAKS
        {
            xi.item.DISPERSERS_CAPE,
            xi.item.PHILIDOR_MANTLE,
            xi.item.SOKOLSKI_MANTLE,
            xi.item.QUARREL_MANTLE,
        },
    },
    -- Kupon AW-UWIII: Unity Wanted Battles 119 - 145 (MOG_KUPON_AW_UWIII = 9179)
    [40] =
    {
            -- HAND-TO-HAND WEAPONS,
        {
            xi.item.FISTS_OF_FURY_P1,
            xi.item.EMEICI_P1,
            xi.item.COMEUPPANCES_P1,
        },
            -- DAGGERS,
        {
            xi.item.JUGO_KUKRI_P1,
            xi.item.ANATHEMA_HARPE_P1,
            xi.item.TERNION_DAGGER_P1,
            xi.item.KUSTAWI_P1,
        },
            -- SWORDS,
        {
            xi.item.SANGARIUS_P1,
            xi.item.PUKULATMUJ_P1,
            xi.item.DEMERSAL_DEGEN_P1,
            xi.item.TANMOGAYI_P1,
            xi.item.FLYSSA_P1,
            xi.item.COMBUSTER_P1,
        },
            -- GREAT SWORDS,
        {
            xi.item.KLADENETS_P1,
            xi.item.MONTANTE_P1,
            xi.item.NULLIS_P1,
            xi.item.USHENZI_P1,
        },
            -- AXES,
        {
            xi.item.BURAMGH_P1,
            xi.item.PERUN_P1,
            xi.item.MDOMO_AXE_P1,
            xi.item.HABILITATOR_P1,
        },
            -- GREAT AXES,
        {
            xi.item.AIZKORA_P1,
            xi.item.BEHEADER_P1,
        },
            -- POLEARMS,
        {
            xi.item.GAE_DERG_P1,
        },
            -- SCYTHES,
        {
            xi.item.TRISKA_SCYTHE_P1,
            xi.item.PIXQUIZPAN_P1,
        },
            -- KATANAS,
        {
            xi.item.TANCHO_P1,
            xi.item.RAICHO_P1,
        },
            -- GREAT KATANAS,
        {
            xi.item.KUNIMUNE_P1,
            xi.item.NORIFUSA_P1,
        },
            -- CLUBS,
        {
            xi.item.MAGESMASHER_P1,
            xi.item.LOXOTIC_MACE_P1,
            xi.item.SEPTOPTIC_P1,
        },
            -- STAVES,
        {
            xi.item.POUWHENUA_P1,
            xi.item.ABABINILI_P1,
            xi.item.MARIN_STAFF_P1,
            xi.item.CONTEMPLATOR_P1,
        },
            -- THROWING WEAPONS,
        {
            xi.item.WINGCUTTER_P1,
            xi.item.GHASTLY_TATHLUM_P1,
            xi.item.SEETHING_BOMBLET_P1,
            xi.item.ANTITAIL_P1,
        },
            -- BOWS,
        {
            xi.item.MENGADO_P1,
            xi.item.PALOMA_BOW_P1,
        },
            -- GUNS,
        {
            xi.item.MALISON_P1,
            xi.item.IMATI_P1,
        },
            -- SHIELDS,
        {
            xi.item.EVALACH_P1,
            xi.item.AJAX_P1,
            xi.item.DELIVERANCE_P1,
            xi.item.FORFEND_P1,
        },
        { --[[ INSTRUMENTS --]] },
            -- GRIPS,
        {
            xi.item.RIGOROUS_GRIP_P1,
            xi.item.REFINED_GRIP_P1,
        },
            -- HEADGEAR,
        {
            xi.item.IMPERIAL_WING_HAIRPIN_P1,
            xi.item.ADORNED_HELM_P1,
            xi.item.STINGER_HELM_P1,
            xi.item.HIKE_KHAT_P1,
            xi.item.ALHAZEN_HAT_P1,
            xi.item.BLISTERING_SALLET_P1,
            xi.item.LOESS_BARBUTA_P1,
        },
            -- CHEST ARMOR,
        {
            xi.item.ROSETTE_JASERAN_P1,
            xi.item.EMET_HARNESS_P1,
            xi.item.HIME_DOMARU_P1,
            xi.item.SHOMONJIJOE_P1,
            xi.item.LUGRA_CLOAK_P1,
            xi.item.AGONY_JERKIN_P1,
            xi.item.COHORT_CLOAK_P1,
            xi.item.TATENASHI_HARAMAKI_P1,
            xi.item.OBVIATION_CUIRASS_P1,
        },
            -- GLOVES AND GAUNTLETS,
        {
            xi.item.MACABRE_GAUNTLETS_P1,
            xi.item.SHIGURE_TEKKO_P1,
            xi.item.KACHIMUSHA_KOTE_P1,
            xi.item.ASTERIA_MITTS_P1,
            xi.item.LAMASSU_MITTS_P1,
            xi.item.TATENASHI_GOTE_P1,
            xi.item.GAZU_BRACELETS_P1,
        },
            -- LEG ARMOR,
        {
            xi.item.ASSIDUITY_PANTS_P1,
            xi.item.AUGURY_CUISSES_P1,
            xi.item.ZOAR_SUBLIGAR_P1,
            xi.item.TATENASHI_HAIDATE_P1,
        },
            -- BOOTS AND GREAVES,
        {
            xi.item.REGAL_PUMPS_P1,
            xi.item.JUTE_BOOTS_P1,
            xi.item.HIPPOMENES_SOCKS_P1,
            xi.item.HYGIEIA_CLOGS_P1,
            xi.item.TATENASHI_SUNE_ATE_P1,
        },
            -- NECK PIECES,
        {
            xi.item.UNMOVING_COLLAR_P1,
            xi.item.CANTO_NECKLACE_P1,
            xi.item.WARDERS_CHARM_P1,
            xi.item.BATHY_CHOKER_P1,
            xi.item.VIM_TORQUE_P1,
            xi.item.LORICATE_TORQUE_P1,
        },
            -- EARRINGS,
        {
            xi.item.NOURISHING_EARRING_P1,
            xi.item.HANDLERS_EARRING_P1,
            xi.item.ARETE_DEL_LUNA_P1,
            xi.item.LUGRA_EARRING_P1,
            xi.item.ZWAZO_EARRING_P1,
            xi.item.DOMINANCE_EARRING_P1,
            xi.item.ODNOWA_EARRING_P1,
        },
            -- BELTS AND SASHES,
        {
            xi.item.SHINJUTSU_NO_OBI_P1,
            xi.item.SAILFI_BELT_P1,
            xi.item.ACUITY_BELT_P1,
            xi.item.KENTARCH_BELT_P1,
        },
            -- RINGS,
        {
            xi.item.METAMORPH_RING_P1,
            xi.item.APEILE_RING_P1,
            xi.item.MEPHITASS_RING_P1,
            xi.item.GELATINOUS_RING_P1,
            xi.item.CACOETHIC_RING_P1,
        },
            -- CAPES AND CLOAKS,
        {
            xi.item.GROUNDED_MANTLE_P1,
            xi.item.FI_FOLLET_CAPE_P1,
            xi.item.AURISTS_CAPE_P1,
        },
            -- OTHER,
        {
            xi.item.STINGER_BULLET_POUCH,
        },
    },
    -- Kupon AW-UWII: Unity Wanted Battles 119 - 128 (MOG_KUPON_AW_UWII = 9180)
    [41] =
    {
            -- HAND-TO-HAND WEAPONS,
        {
            xi.item.FISTS_OF_FURY_P1,
            xi.item.EMEICI_P1,
        },
            -- DAGGERS,
        {
            xi.item.JUGO_KUKRI_P1,
            xi.item.ANATHEMA_HARPE_P1,
            xi.item.TERNION_DAGGER_P1,
            xi.item.KUSTAWI_P1,
        },
            -- SWORDS,
        {
            xi.item.SANGARIUS_P1,
            xi.item.PUKULATMUJ_P1,
            xi.item.DEMERSAL_DEGEN_P1,
        },
            -- GREAT SWORDS,
        {
            xi.item.KLADENETS_P1,
            xi.item.USHENZI_P1,
        },
            -- AXES,
        {
            xi.item.BURAMGH_P1,
            xi.item.PERUN_P1,
            xi.item.MDOMO_AXE_P1,
        },
            -- GREAT AXES,
        {
            xi.item.AIZKORA_P1,
            xi.item.BEHEADER_P1,
        },
            -- POLEARMS,
        {
            xi.item.GAE_DERG_P1,
        },
            -- SCYTHES,
        {
            xi.item.TRISKA_SCYTHE_P1,
            xi.item.PIXQUIZPAN_P1,
        },
            -- KATANAS,
        {
            xi.item.TANCHO_P1,
            xi.item.RAICHO_P1,
        },
            -- GREAT KATANAS,
        {
            xi.item.KUNIMUNE_P1,
            xi.item.NORIFUSA_P1,
        },
            -- CLUBS,
        {
            xi.item.MAGESMASHER_P1,
            xi.item.LOXOTIC_MACE_P1,
        },
            -- STAVES,
        {
            xi.item.POUWHENUA_P1,
            xi.item.ABABINILI_P1,
            xi.item.MARIN_STAFF_P1,
        },
            -- THROWING WEAPONS,
        {
            xi.item.WINGCUTTER_P1,
            xi.item.GHASTLY_TATHLUM_P1,
            xi.item.SEETHING_BOMBLET_P1,
        },
            -- BOWS,
        {
            xi.item.MENGADO_P1,
            xi.item.PALOMA_BOW_P1,
        },
            -- GUNS,
        {
            xi.item.IMATI_P1,
        },
            -- SHIELDS,
        {
            xi.item.EVALACH_P1,
            xi.item.AJAX_P1,
            xi.item.DELIVERANCE_P1,
        },
        { --[[ INSTRUMENTS --]] },
            -- GRIPS,
        {
            xi.item.RIGOROUS_GRIP_P1,
            xi.item.REFINED_GRIP_P1,
        },
            -- HEADGEAR,
        {
            xi.item.IMPERIAL_WING_HAIRPIN_P1,
            xi.item.ADORNED_HELM_P1,
            xi.item.STINGER_HELM_P1,
            xi.item.HIKE_KHAT_P1,
            xi.item.ALHAZEN_HAT_P1,
            xi.item.BLISTERING_SALLET_P1,
        },
            -- CHEST ARMOR,
        {
            xi.item.ROSETTE_JASERAN_P1,
            xi.item.EMET_HARNESS_P1,
            xi.item.HIME_DOMARU_P1,
            xi.item.SHOMONJIJOE_P1,
            xi.item.LUGRA_CLOAK_P1,
            xi.item.AGONY_JERKIN_P1,
            xi.item.COHORT_CLOAK_P1,
        },
            -- GLOVES AND GAUNTLETS,
        {
            xi.item.MACABRE_GAUNTLETS_P1,
            xi.item.SHIGURE_TEKKO_P1,
            xi.item.KACHIMUSHA_KOTE_P1,
            xi.item.ASTERIA_MITTS_P1,
            xi.item.LAMASSU_MITTS_P1,
            xi.item.GAZU_BRACELETS_P1,
        },
            -- LEG ARMOR,
        {
            xi.item.ASSIDUITY_PANTS_P1,
            xi.item.AUGURY_CUISSES_P1,
            xi.item.ZOAR_SUBLIGAR_P1,
        },
            -- BOOTS AND GREAVES,
        {
            xi.item.REGAL_PUMPS_P1,
            xi.item.JUTE_BOOTS_P1,
            xi.item.HIPPOMENES_SOCKS_P1,
            xi.item.HYGIEIA_CLOGS_P1,
        },
            -- NECK PIECES,
        {
            xi.item.UNMOVING_COLLAR_P1,
            xi.item.CANTO_NECKLACE_P1,
            xi.item.WARDERS_CHARM_P1,
            xi.item.BATHY_CHOKER_P1,
        },
            -- EARRINGS,
        {
            xi.item.NOURISHING_EARRING_P1,
            xi.item.HANDLERS_EARRING_P1,
            xi.item.ARETE_DEL_LUNA_P1,
            xi.item.LUGRA_EARRING_P1,
            xi.item.ZWAZO_EARRING_P1,
            xi.item.ODNOWA_EARRING_P1,
        },
            -- BELTS AND SASHES,
        {
            xi.item.SHINJUTSU_NO_OBI_P1,
            xi.item.SAILFI_BELT_P1,
            xi.item.ACUITY_BELT_P1,
            xi.item.KENTARCH_BELT_P1,
        },
            -- RINGS,
        {
            xi.item.METAMORPH_RING_P1,
            xi.item.APEILE_RING_P1,
            xi.item.MEPHITASS_RING_P1,
            xi.item.GELATINOUS_RING_P1,
            xi.item.CACOETHIC_RING_P1,
        },
            -- CAPES AND CLOAKS,
        {
            xi.item.GROUNDED_MANTLE_P1,
            xi.item.FI_FOLLET_CAPE_P1,
            xi.item.AURISTS_CAPE_P1,
        },
            -- OTHER,
        {
            xi.item.STINGER_BULLET_POUCH,
        },
    },
    -- Kupon AW-UW: Unity Wanted Battles 119 (MOG_KUPON_AW_UW = 9181)
    [42] =
    {
        xi.item.BURAMGH_P1,
        xi.item.TANCHO_P1,
        xi.item.WINGCUTTER_P1,
        xi.item.EVALACH_P1,
        xi.item.IMPERIAL_WING_HAIRPIN_P1,
        xi.item.MACABRE_GAUNTLETS_P1,
        xi.item.ASSIDUITY_PANTS_P1,
        xi.item.REGAL_PUMPS_P1,
        xi.item.HIPPOMENES_SOCKS_P1,
        xi.item.UNMOVING_COLLAR_P1,
        xi.item.NOURISHING_EARRING_P1,
        xi.item.METAMORPH_RING_P1,
        xi.item.APEILE_RING_P1,
        xi.item.SHINJUTSU_NO_OBI_P1,
    },
    -- Kupon A-Ab: iLevel 119 P1 Abjuration Armor Sets (MOG_KUPON_A_AB = 9178)
    [43] =
    {
        {
            xi.item.ARGOSY_CELATA_P1,
            xi.item.ARGOSY_HAUBERK_P1,
            xi.item.ARGOSY_MUFFLERS_P1,
            xi.item.ARGOSY_BREECHES_P1,
            xi.item.ARGOSY_SOLLERETS_P1,
        },
        {
            xi.item.ADHEMAR_BONNET_P1,
            xi.item.ADHEMAR_JACKET_P1,
            xi.item.ADHEMAR_WRISTBANDS_P1,
            xi.item.ADHEMAR_KECKS_P1,
            xi.item.ADHEMAR_GAMASHES_P1,
        },
        {
            xi.item.APOGEE_CROWN_P1,
            xi.item.APOGEE_DALMATICA_P1,
            xi.item.APOGEE_MITTS_P1,
            xi.item.APOGEE_SLACKS_P1,
            xi.item.APOGEE_PUMPS_P1,
        },
        {
            xi.item.AMALRIC_COIF_P1,
            xi.item.AMALRIC_DOUBLET_P1,
            xi.item.AMALRIC_GAGES_P1,
            xi.item.AMALRIC_SLOPS_P1,
            xi.item.AMALRIC_NAILS_P1,
        },
        {
            xi.item.EMICHO_CORONET_P1,
            xi.item.EMICHO_HAUBERT_P1,
            xi.item.EMICHO_GAUNTLETS_P1,
            xi.item.EMICHO_HOSE_P1,
            xi.item.EMICHO_GAMBIERAS_P1,
        },
        {
            xi.item.CARMINE_MASK_P1,
            xi.item.CARMINE_SCALE_MAIL_P1,
            xi.item.CARMINE_FINGER_GAUNTLETS_P1,
            xi.item.CARMINE_CUISSES_P1,
            xi.item.CARMINE_GREAVES_P1,
        },
        {
            xi.item.KAYKAUS_MITRA_P1,
            xi.item.KAYKAUS_BLIAUT_P1,
            xi.item.KAYKAUS_CUFFS_P1,
            xi.item.KAYKAUS_TIGHTS_P1,
            xi.item.KAYKAUS_BOOTS_P1,
        },
        {
            xi.item.SOUVERAN_SCHALLER_P1,
            xi.item.SOUVERAN_CUIRASS_P1,
            xi.item.SOUVERAN_HANDSCHUHS_P1,
            xi.item.SOUVERAN_DIECHLINGS_P1,
            xi.item.SOUVERAN_SCHUHS_P1,
        },
        {
            xi.item.LUSTRATIO_CAP_P1,
            xi.item.LUSTRATIO_HARNESS_P1,
            xi.item.LUSTRATIO_MITTENS_P1,
            xi.item.LUSTRATIO_SUBLIGAR_P1,
            xi.item.LUSTRATIO_LEGGINGS_P1,
        },
        {
            xi.item.RAO_KABUTO_P1,
            xi.item.RAO_TOGI_P1,
            xi.item.RAO_KOTE_P1,
            xi.item.RAO_HAIDATE_P1,
            xi.item.RAO_SUNE_ATE_P1,
        },
        {
            xi.item.RYUO_SOMEN_P1,
            xi.item.RYUO_DOMARU_P1,
            xi.item.RYUO_TEKKO_P1,
            xi.item.RYUO_HAKAMA_P1,
            xi.item.RYUO_SUNE_ATE_P1,
        },
    },

    -- Kupon AW-Cos: Various Costumes (MOG_KUPON_AW_COS = 9182)
    -- Some items are gender specific, with varying shifts between the F/M versions of
    -- items. Index defaults to the itemID for the Female version of the item, and
    -- has the shift distance specififed as a second param. Final/actual itemID is
    -- processed in getItemSelection.
    --
    -- Example: { xi.item.COSSIE_TOP_P1,         2 }, itemID 26968, shift value of 2
    --          The Male version of the item is xi.item.TA_MOKO_P1 = 26966
    [44] =
    {
            -- HAND-TO-HAND WEAPONS
        {
            { xi.item.WORM_FEELERS_P1          },
        },
            -- SWORDS
        {
            { xi.item.IBUSHI_SHINAI_P1         },
            { xi.item.ARK_SABER                },
            { xi.item.ARK_SWORD                },
            { xi.item.EXCALIPOOR_II            },
        },
            -- AXES
        {
            { xi.item.ARK_TABAR                },
        },
            -- POLEARMS
        {
            { xi.item.PITCHFORK_P1             },
        },
            -- SCYTHES
        {
            { xi.item.ARK_SCYTHE               },
        },
            -- GREAT KATANAS
        {
            { xi.item.HARDWOOD_KATANA          },
            { xi.item.LOTUS_KATANA             },
            { xi.item.SHINAI                   },
            { xi.item.ARK_TACHI                },
        },
            -- CLUBS
        {
            { xi.item.CHOCOBO_WAND             },
            { xi.item.CHARM_WAND_P1            },
            { xi.item.NOMAD_MOOGLE_ROD         },
            { xi.item.MIRACLE_WAND_P1          },
            { xi.item.BATTLEDORE               },
            { xi.item.DREAM_BELL_P1            },
            { xi.item.HEARTSTOPPER_P1          },
            { xi.item.HEARTBEATER_P1           },
            { xi.item.LEAFKIN_BOPPER_P1        },
            { xi.item.KYUKA_UCHIWA_P1          },
            { xi.item.PURPLE_SPRIGGAN_CLUB     },
            { xi.item.RED_SPRIGGAN_CLUB        },
            { xi.item.HAGOITA                  },
            { xi.item.GREEN_SPRIGGAN_CLUB      },
            { xi.item.SEIKA_UCHIWA_P1          },
            { xi.item.JINGLY_ROD_P1            },
        },
            -- STAVES
        {
            { xi.item.TREAT_STAFF              },
            { xi.item.TREAT_STAFF_II           },
            { xi.item.MALICE_MASHER_P1         },
        },
            -- SHIELDS
        {
            { xi.item.JANUS_GUARD              },
            { xi.item.MOOGLE_GUARD_P1          },
            { xi.item.CHOCOBO_SHIELD_P1        },
            { xi.item.CASSIES_SHIELD           },
            { xi.item.CAIT_SITH_GUARD_P1       },
            { xi.item.SHE_SLIME_SHIELD         },
            { xi.item.METAL_SLIME_SHIELD       },
            { xi.item.HATCHLING_SHIELD         },
            { xi.item.MUNDUS_SHIELD            },
            { xi.item.SLIME_SHIELD             },
            { xi.item.GLINTING_SHIELD          },
        },
            -- HEADGEAR 1
        {
            { xi.item.DECENNIAL_TIARA_P1,    1 },
            { xi.item.PYRACMON_CAP             },
            { xi.item.SNOW_BUNNY_HAT_P1        },
            { xi.item.HORROR_HEAD              },
            { xi.item.HORROR_HEAD_II           },
            { xi.item.DREAM_HAT_P1             },
            { xi.item.COVEN_HAT                },
            { xi.item.EGG_HELM                 },
            { xi.item.REDEYES                  },
            { xi.item.BUFFALO_CAP              },
            { xi.item.STARLET_FLOWER,        1 },
            { xi.item.CARBIE_CAP_P1            },
            { xi.item.CASSIES_CAP              },
            { xi.item.LYCOPODIUM_MASQUE_P1     },
            { xi.item.MANDRAGORA_MASQUE_P1     },
            { xi.item.FLAN_MASQUE_P1           },
            { xi.item.CAIT_SITH_CAP_P1         },
            { xi.item.SHEEP_CAP_P1             },
            { xi.item.FROSTY_CAP               },
            { xi.item.COROLLA                  },
            { xi.item.CELESTE_CAP              },
            { xi.item.LEAFKIN_CAP_P1           },
            { xi.item.RABBIT_CAP               },
            { xi.item.SHOBUHOUOU_KABUTO        },
            { xi.item.BEHEMOTH_MASQUE_P1       },
            { xi.item.GOBLIN_MASQUE            },
            { xi.item.GREEN_MOOGLE_MASQUE      },
            { xi.item.WORM_MASQUE_P1           },
            { xi.item.SHE_SLIME_HAT            },
            { xi.item.METAL_SLIME_HAT          },
        },
            -- HEADGEAR 2
        {
            { xi.item.SLIME_CAP                },
            { xi.item.BOMB_MASQUE_P1           },
            { xi.item.CHOCOBO_MASQUE_P1        },
            { xi.item.WYRMKING_MASQUE_P1       },
            { xi.item.SNOLL_MASQUE_P1          },
            { xi.item.RARAB_CAP_P1             },
            { xi.item.CRAB_CAP_P1              },
            { xi.item.KAKAI_CAP_P1             },
            { xi.item.CUMULUS_MASQUE_P1        },
        },
            -- CHEST ARMOR
        {
            { xi.item.DECENNIAL_DRESS_P1,    1 },
            { xi.item.EERIE_CLOAK_P1           },
            { xi.item.OMINAESHI_YUKATA,      1 },
            { xi.item.DINNER_JACKET            },
            { xi.item.NOVENNIAL_DRESS,       1 },
            { xi.item.HIMEGAMI_YUKATA,       1 },
            { xi.item.LADYS_YUKATA,          1 },
            { xi.item.DREAM_ROBE_P1            },
            { xi.item.ONNAGIMI_YUKATA,       1 },
            { xi.item.BOTULUS_SUIT_P1          },
            { xi.item.TRACK_SHIRT_P1           },
            { xi.item.HEART_APRON_P1           },
            { xi.item.PUPILS_SHIRT             },
            { xi.item.BEHEMOTH_SUIT_P1         },
            { xi.item.POROGGO_COAT_P1          },
            { xi.item.COSSIE_TOP_P1,         2 },
            { xi.item.STARLET_JABOT,         1 },
            { xi.item.SHOAL_MAILLOT_P1,      1 },
            { xi.item.MANDRAGORA_SUIT_P1       },
            { xi.item.SHOKUJO_HAPPI,         1 },
            { xi.item.GOBLIN_SUIT              },
            { xi.item.GREEN_MOOGLE_SUIT        },
            { xi.item.PURPLE_SPRIGGAN_COAT     },
            { xi.item.RED_SPRIGGAN_COAT        },
            { xi.item.ALLIANCE_SHIRT_P1        },
            { xi.item.GREEN_SPRIGGAN_COAT      },
            { xi.item.CHOCOBO_SUIT_P1          },
            { xi.item.WYRMKING_SUIT_P1         },
            { xi.item.RHAPSODY_SHIRT_P1        },
            { xi.item.AKITU_SHIRT              },
        },
            -- CHEST ARMOR 2
        {
            { xi.item.JUBILEE_SHIRT            },
        },
            -- GLOVES AND GAUNTLETS
        {
            { xi.item.DREAM_MITTENS_P1         },
            { xi.item.STARLET_GLOVES,        1 },
        },
            -- LEG ARMOR
        {
            { xi.item.DECENNIAL_HOSE_P1,     1 },
            { xi.item.NOVENNIAL_THIGH_BOOTS, 1 },
            { xi.item.DREAM_PANTS_P1,        2 },
            { xi.item.DINNER_HOSE              },
            { xi.item.PUPILS_TROUSERS          },
            { xi.item.COSSIE_BOTTOM_P1,      2 },
            { xi.item.STARLET_SKIRT,         1 },
            { xi.item.TRACK_PANTS_P1           },
            { xi.item.SHOAL_TRUNKS_P1,       1 },
            { xi.item.SHOKUJO_HANMOMOHIKI,   1 },
            { xi.item.ALLIANCE_PANTS           },
        },
            -- BOOTS AND GREAVES
        {
            { xi.item.DREAM_BOOTS_P1           },
            { xi.item.PUPILS_SHOES             },
            { xi.item.STARLET_BOOTS,         1 },
            { xi.item.ALLIANCE_BOOTS           },
        },
    },

    -- Kupon AW-Kupo: All four Kupo items
    [45] =
    {
        {
            xi.item.KUPO_ROD,
            xi.item.KUPO_MASQUE,
            xi.item.KUPO_SUIT,
            xi.item.KUPO_SHIELD,
        },
    },

    -- Kupon W-EMI: iLevel 117 Sparks of Eminence Weapons (MOG_KUPON_W_EMI = 9188)
    [46] =
    {
        xi.item.EMINENT_BAGHNAKHS,
        xi.item.EMINENT_DAGGER,
        xi.item.EMINENT_SCIMITAR,
        xi.item.EMINENT_SWORD,
        xi.item.EMINENT_AXE,
        xi.item.EMINENT_VOULGE,
        xi.item.EMINENT_SICKLE,
        xi.item.EMINENT_LANCE,
        xi.item.KAITSUBURI,
        xi.item.ICHIMONJI_YOFUSA,
        xi.item.EMINENT_WAND,
        xi.item.EMINENT_STAFF,
        xi.item.EMINENT_POLE,
        xi.item.EMINENT_BOW,
        xi.item.EMINENT_CROSSBOW,
        xi.item.EMINENT_GUN,
        xi.item.EMINENT_SHIELD,
        xi.item.EMINENT_ANIMATOR,
        xi.item.EMINENT_SACHET,
        xi.item.EMINENT_BELL,
        xi.item.EMINENT_FLUTE,
        xi.item.EMINENT_ANIMATOR_II,
    },

    -- Kupon A-EMI: iLevel 117 Records of Eminence armor (MOG_KUPON_A_EMI = 9226)
    [47] =
    {
        {
            xi.item.OUTRIDER_MASK,
            xi.item.OUTRIDER_MAIL,
            xi.item.OUTRIDER_MITTENS,
            xi.item.OUTRIDER_HOSE,
            xi.item.OUTRIDER_GREAVES,
        },
        {
            xi.item.ESPIAL_CAP,
            xi.item.ESPIAL_GAMBISON,
            xi.item.ESPIAL_BRACERS,
            xi.item.ESPIAL_HOSE,
            xi.item.ESPIAL_SOCKS,
        },
        {
            xi.item.WAYFARER_CIRCLET,
            xi.item.WAYFARER_ROBE,
            xi.item.WAYFARER_CUFFS,
            xi.item.WAYFARER_SLOPS,
            xi.item.WAYFARER_CLOGS,
        },
    },

    -- Kupon W-SRW: Rala Waterways Skirmish Weapons +2 (MOG_KUPON_W_SRW = 9189)
    [48] =
    {
        xi.item.AEDOLD_P2,
        xi.item.CROBACI_P2,
        xi.item.FAIZZEER_P2,
        xi.item.HGAFIRCIAN_P2,
        xi.item.ICLAMAR_P2,
        xi.item.KANNAKIRI_P2,
        xi.item.LEHBRAILG_P2,
    },

    -- Kupon W-SCC: Cirdas Caverns Skirmish Weapons +2 (MOG_KUPON_W_SCC = 9190)
    [49] =
    {
        xi.item.NINZAS_P2,
        xi.item.LEISILONU_P2,
        xi.item.IZTAASU_P2,
        xi.item.IIZAMAL_P2,
        xi.item.QATSUNOCI_P2,
        xi.item.SHICHISHITO_P2,
        xi.item.UFFRAT_P2,
        xi.item.BOCLUAMNI_P2,
    },

    -- Kupon A-SYW: Yorcia Weald Skirmish Armor +1 (MOG_KUPON_A_SYW = 9227)
    [50] =
    {
        {
            xi.item.CIZIN_HELM_P1,
            xi.item.CIZIN_MAIL_P1,
            xi.item.CIZIN_MUFFLERS_P1,
            xi.item.CIZIN_BREECHES_P1,
            xi.item.CIZIN_GREAVES_P1,
        },
        {
            xi.item.OTRONIF_MASK_P1,
            xi.item.OTRONIF_HARNESS_P1,
            xi.item.OTRONIF_GLOVES_P1,
            xi.item.OTRONIF_BRAIS_P1,
            xi.item.OTRONIF_BOOTS_P1,
        },
        {
            xi.item.IUITL_HEADGEAR_P1,
            xi.item.IUITL_VEST_P1,
            xi.item.IUITL_WRISTBANDS_P1,
            xi.item.IUITL_TIGHTS_P1,
            xi.item.IUITL_GAITERS_P1,
        },
        {
            xi.item.GENDEWITHA_CAUBEEN_P1,
            xi.item.GENDEWITHA_BLIAUT_P1,
            xi.item.GENDEWITHA_GAGES_P1,
            xi.item.GENDEWITHA_SPATS_P1,
            xi.item.GENDEWITHA_GALOSHES_P1,
        },
        {
            xi.item.HAGONDES_HAT_P1,
            xi.item.HAGONDES_COAT_P1,
            xi.item.HAGONDES_CUFFS_P1,
            xi.item.HAGONDES_PANTS_P1,
            xi.item.HAGONDES_SABOTS_P1,
        },
        {
            xi.item.BEATIFIC_SHIELD_P1,
        },
    },
    -- Kupon W-ASRW: Rala Waterways Alluvion Skirmish Weapons (MOG_KUPON_W_ASRW = 9191)
    [51] =
    {
        xi.item.OHRMAZD,
        xi.item.IPETAM,
        xi.item.CLAIDHEAMH_SOLUIS,
        xi.item.MACBAIN,
        xi.item.KUMBHAKARNA,
        xi.item.SVARGA,
        xi.item.INANNA,
        xi.item.KERAUNOS,
    },

    -- Kupon W-ASCC: Cirdas Caverns Alluvion Skirmish Weapons (MOG_KUPON_W_ASCC = 9192)
    [52] =
    {
        xi.item.OLYNDICUS,
        xi.item.IZUNA,
        xi.item.NENEKIRIMARU,
        xi.item.NEHUSHTAN,
        xi.item.PHAOSPHAELIA,
        xi.item.LINOS,
        xi.item.DOOMSDAY,
        xi.item.SVALINN,
    },

    -- Kupon A-ASYW: Yorcia Weald Alluvion Skirmish Armor (MOG_KUPON_A_ASYW = 9228)
    [53] =
    {
        {
            xi.item.YORIUM_BARBUTA,
            xi.item.YORIUM_CUIRASS,
            xi.item.YORIUM_GAUNTLETS,
            xi.item.YORIUM_CUISSES,
            xi.item.YORIUM_SABATONS,
        },
        {
            xi.item.ACRO_HELM,
            xi.item.ACRO_SURCOAT,
            xi.item.ACRO_GAUNTLETS,
            xi.item.ACRO_BREECHES,
            xi.item.ACRO_LEGGINGS,
        },
        {
            xi.item.TAEON_CHAPEAU,
            xi.item.TAEON_TABARD,
            xi.item.TAEON_GLOVES,
            xi.item.TAEON_TIGHTS,
            xi.item.TAEON_BOOTS,
        },
        {
            xi.item.TELCHINE_CAP,
            xi.item.TELCHINE_CHASUBLE,
            xi.item.TELCHINE_GLOVES,
            xi.item.TELCHINE_BRACONI,
            xi.item.TELCHINE_PIGACHES,
        },
        {
            xi.item.HELIOS_BAND,
            xi.item.HELIOS_JACKET,
            xi.item.HELIOS_GLOVES,
            xi.item.HELIOS_SPATS,
            xi.item.HELIOS_BOOTS,
        },
    },
    -- Kupon W-R119: iLevel 119 III Relic Weapons (MOG_KUPON_W_R119 = 9183)
    [54] =
    {
        xi.item.SPHARAI_119_III,
        xi.item.MANDAU_119_III,
        xi.item.EXCALIBUR_119_III,
        xi.item.RAGNAROK_119_III,
        xi.item.GUTTLER_119_III,
        xi.item.BRAVURA_119_III,
        xi.item.APOCALYPSE_119_III,
        xi.item.GUNGNIR_119_III,
        xi.item.KIKOKU_119_III,
        xi.item.AMANOMURAKUMO_119_III,
        xi.item.MJOLLNIR_119_III,
        xi.item.CLAUSTRUM_119_III,
        xi.item.YOICHINOYUMI_119_III,  -- Quiver Version
        xi.item.ANNIHILATOR_119_III,   -- Quiver Version
    },

    -- Kupon W-M119: iLevel 119 III Mythic Weapons and Ergon Weapons (MOG_KUPON_W_M119 = 9184)
    [55] =
    {
        xi.item.GLANZFAUST_119_III,
        xi.item.KENKONKEN_119_III,
        xi.item.VAJRA_119_III,
        xi.item.CARNWENHAN_119_III,
        xi.item.TERPSICHORE_119_III,
        xi.item.MURGLEIS_119_III,
        xi.item.BURTGANG_119_III,
        xi.item.TIZONA_119_III,
        xi.item.EPEOLATRY_119_II,
        xi.item.AYMUR_119_III,
        xi.item.CONQUEROR_119_III,
        xi.item.LIBERATOR_119_III,
        xi.item.RYUNOHIGE_119_III,
        xi.item.NAGI_119_III,
        xi.item.KOGARASUMARU_119_III,
        xi.item.YAGRUSH_119_III,
        xi.item.IDRIS_119_II,
        xi.item.LAEVATEINN_119_III,
        xi.item.NIRVANA_119_III,
        xi.item.TUPSIMATI_119_III,
        xi.item.GASTRAPHETES_119_III,  -- Quiver Version
        xi.item.DEATH_PENALTY_119_III, -- Quiver Version
    },

    -- Kupon W-E119: iLevel 119 III Empyrean Weapons (MOG_KUPON_W_E119 = 9185)
    [56] =
    {
        xi.item.VERETHRAGNA_119_III,
        xi.item.TWASHTAR_119_III,
        xi.item.ALMACE_119_III,
        xi.item.CALADBOLG_119_III,
        xi.item.FARSHA_119_III,
        xi.item.UKONVASARA_119_III,
        xi.item.REDEMPTION_119_III,
        xi.item.RHONGOMIANT_119_III,
        xi.item.KANNAGI_119_III,
        xi.item.MASAMUNE_119_III,
        xi.item.GAMBANTEINN_119_III,
        xi.item.HVERGELMIR_119_III,
        xi.item.GANDIVA_119_III,       -- Quiver Version
        xi.item.ARMAGEDDON_119_III,    -- Quiver Version
    },

    -- Kupon W-A119: Aeonic Weapons (MOG_KUPON_W_A119 = 9186)
    [57] =
    {
        xi.item.GODHANDS,
        xi.item.AENEAS,
        xi.item.SEQUENCE,
        xi.item.LIONHEART,
        xi.item.TRI_EDGE,
        xi.item.CHANGO,
        xi.item.TRISHULA,
        xi.item.ANGUTA,
        xi.item.HEISHI_SHORINKEN,
        xi.item.DOJIKIRI_YASUTSUNA,
        xi.item.TISHTRYA,
        xi.item.KHATVANGA,
        xi.item.FAIL_NOT,      -- Quiver Version
        xi.item.FOMALHAUT,     -- Quiver Version
        xi.item.SRIVATSA,
        xi.item.MARSYAS,
    },

    -- Kupon AW-GeIV: Geas Fete (Any Content Level) (MOG_KUPON_AW_GEIV = 9187)
    [58] =
    {
            -- HAND-TO-HAND WEAPONS
        {
            xi.item.NIBIRU_SAINTI,
            xi.item.CHASTISERS,
            xi.item.HAMMERFISTS,
            xi.item.MIDNIGHTS,
            xi.item.ESHUS,
            xi.item.CONDEMNERS,
            xi.item.SUWAIYAS,
        },
            -- DAGGERS
        {
            xi.item.NIBIRU_KNIFE,
            xi.item.ENCHUFLA,
            xi.item.SHIJO,
            xi.item.KALI,
            xi.item.SKINFLAYER,
            xi.item.SANGOMA,
        },
            -- SWORDS
        {
            xi.item.NIBIRU_BLADE,
            xi.item.NIXXER,
            xi.item.EMISSARY,
            xi.item.IRIS,
            xi.item.COLADA,
            xi.item.FIRANGI,
            xi.item.DEACON_SABER,
            xi.item.DEACON_SWORD,
            xi.item.KOBOTO,
            xi.item.REIKIKO,
        },
            -- GREAT SWORDS
        {
            xi.item.NIBIRU_FAUSSAR,
            xi.item.BIDENHANDER,
            xi.item.ZULFIQAR,
            xi.item.TAKOBA,
        },
            -- AXES
        {
            xi.item.NIBIRU_TABAR,
            xi.item.SKULLRENDER,
            xi.item.DIGIRBALAG,
            xi.item.FREYDIS,
            xi.item.DEACON_TABAR,
        },
            -- GREAT AXES
        {
            xi.item.NIBIRU_CHOPPER,
            xi.item.ROUTER,
            xi.item.INSTIGATOR,
            xi.item.AGANOSHE,
            xi.item.HODADENON,
            xi.item.REIKIONO,
            xi.item.JOKUSHUONO,
        },
            -- POLEARMS
        {
            xi.item.NIBIRU_LANCE,
            xi.item.ANNEALED_LANCE,
            xi.item.RHOMPHAIA,
            xi.item.REIENKYO,
            xi.item.LEMBING,
            xi.item.HABILE_MAZRAK,
        },
            -- SCYTHES
        {
            xi.item.NIBIRU_SICKLE,
            xi.item.DEATHBANE,
            xi.item.OBSCHINE,
            xi.item.MISANTHROPY,
            xi.item.DACNOMANIA,
            xi.item.DEACON_SCYTHE,
            xi.item.SHUKUYUS_SCYTHE,
        },
            -- KATANAS
        {
            xi.item.MIJIN,
            xi.item.AIZUSHINTOGO,
            xi.item.KANARIA,
            xi.item.TAKA,
        },
            -- GREAT KATANAS
        {
            xi.item.SENSUI,
            xi.item.ICHIGOHITOFURI,
            xi.item.UMARU,
            xi.item.SHISHIO,
            xi.item.DEACON_BLADE,
        },
            -- CLUBS
        {
            xi.item.NIBIRU_CUDGEL,
            xi.item.QUELLER_ROD,
            xi.item.SOLSTICE,
            xi.item.SUCELLUS,
            xi.item.GADA,
            xi.item.IZCALLI,
        },
            -- STAVES
        {
            xi.item.NIBIRU_STAFF,
            xi.item.ESPIRITUS,
            xi.item.AKADEMOS,
            xi.item.LATHI,
            xi.item.GRIOAVOLR,
            xi.item.ORANYAN,
            xi.item.GOZUKI_MEZUKI,
            xi.item.REIKIKON,
        },
            -- THROWING WEAPONS
        {
            xi.item.SERAPHIC_AMPULLA,
            xi.item.GRENADE_CORE,
            xi.item.SAPIENCE_ORB,
            xi.item.FALCON_EYE,
            xi.item.ALBIN_BANE,
            xi.item.AMAR_CLUSTER,
            xi.item.HYDROCERA,
            xi.item.MANTOPTERA_EYE,
            xi.item.EXPEDITIOUS_PINION,
            xi.item.PEMPHREDO_TATHLUM,
            xi.item.ELIS_TOME,
        },
            -- BOWS
        {
            xi.item.NIBIRU_BOW,
            xi.item.VIJAYA_BOW,
            xi.item.TELLER,
            xi.item.STEINTHOR,
        },
            -- GUNS
        {
            xi.item.NIBIRU_GUN,
            xi.item.COMPENSATOR,
            xi.item.WOCHOWSEN,
            xi.item.HOLLIDAY,
            xi.item.MOLYBDOSIS,
        },
            -- SHIELDS
        {
            xi.item.NIBIRU_SHIELD,
            xi.item.GENMEI_SHIELD,
        },
            -- INSTRUMENTS
        {
            xi.item.NIBIRU_HARP,
        },
            -- GRIPS
        {
            xi.item.CLEMENCY_GRIP,
            xi.item.WILLPOWER_GRIP,
            xi.item.FOREFATHERS_GRIP,
            xi.item.GIUOCO_GRIP,
            xi.item.BALARAMA_GRIP,
            xi.item.NIOBID_STRAP,
            xi.item.POTENT_GRIP,
            xi.item.THRACE_STRAP,
            xi.item.ALBER_STRAP,
        },
            -- HEADGEAR
        {
            xi.item.ESCHITE_HELM,
            xi.item.PSYCLOTH_TIARA,
            xi.item.RAWHIDE_MASK,
            xi.item.DESPAIR_HELM,
            xi.item.VANYA_HOOD,
            xi.item.PURSUERS_BERET,
            xi.item.NAGA_SOMEN,
            xi.item.SKORMOTH_MASK,
            xi.item.ODYSSEAN_HELM,
            xi.item.VALOROUS_MASK,
            xi.item.HERCULEAN_HELM,
            xi.item.MERLINIC_HOOD,
            xi.item.CHIRONIC_HAT,
            xi.item.IPOCA_BERET,
            xi.item.YNGLINGA_SALLET,
            xi.item.GENMEI_KABUTO,
        },
            -- CHEST ARMOR
        {
            xi.item.ESCHITE_BREASTPLATE,
            xi.item.PSYCLOTH_VEST,
            xi.item.RAWHIDE_VEST,
            xi.item.DESPAIR_MAIL,
            xi.item.VANYA_ROBE,
            xi.item.PURSUERS_DOUBLET,
            xi.item.NAGA_SAMUE,
            xi.item.SWELLERS_HARNESS,
            xi.item.ONCA_SUIT,
            xi.item.KUBIRA_MEIKOGAI,
            xi.item.ANNOINTED_KALASIRIS,
            xi.item.MAKORA_MEIKOGAI,
            xi.item.ENFORCERS_HARNESS,
            xi.item.UAC_JERKIN,
            xi.item.SHANGO_ROBE,
            xi.item.ABNOBA_KAFTAN,
            xi.item.ODYSSEAN_CHESTPLATE,
            xi.item.VALOROUS_MAIL,
            xi.item.HERCULEAN_VEST,
            xi.item.MERLINIC_JUBBAH,
            xi.item.CHIRONIC_DOUBLET,
            xi.item.VEDIC_COAT,
            xi.item.NZINGHA_CUIRASS,
            xi.item.SAYADIOS_KAFTAN,
            xi.item.ZENDIK_ROBE,
            xi.item.REIKI_OSODE,
        },
            -- GLOVES AND GAUNTLETS
        {
            xi.item.NAGA_TEKKO,
            xi.item.ESCHITE_GAUNTLETS,
            xi.item.PSYCLOTH_MANILLAS,
            xi.item.RAWHIDE_GLOVES,
            xi.item.DESPAIR_FINGER_GLOVES,
            xi.item.VANYA_CUFFS,
            xi.item.PURSUERS_CUFFS,
            xi.item.SHRIEKERS_CUFFS,
            xi.item.KURYS_GLOVES,
            xi.item.ODYSSEAN_GAUNTLETS,
            xi.item.VALOROUS_MITTS,
            xi.item.HERCULEAN_GLOVES,
            xi.item.MERLINIC_DASTANAS,
            xi.item.CHIRONIC_GLOVES,
            xi.item.COMPOSERS_MITTS,
            xi.item.MRIGAVYADHA_GLOVES,
            xi.item.IKTOMI_DASTANAS,
            xi.item.KOBO_KOTE,
        },
            -- LEG ARMOR
        {
            xi.item.NAGA_HAKAMA,
            xi.item.ESCHITE_CUISSES,
            xi.item.PSYCLOTH_LAPPAS,
            xi.item.RAWHIDE_TROUSERS,
            xi.item.DESPAIR_CUISSES,
            xi.item.VANYA_SLOPS,
            xi.item.PURSUERS_PANTS,
            xi.item.DOYEN_PANTS,
            xi.item.OBATALA_SUBLIGAR,
            xi.item.SELVANS_SUBLIGAR,
            xi.item.ODYSSEAN_CUISSES,
            xi.item.VALOROUS_HOSE,
            xi.item.HERCULEAN_TROUSERS,
            xi.item.MERLINIC_SHALWAR,
            xi.item.CHIRONIC_HOSE,
            xi.item.ARJUNA_BREECHES,
            xi.item.JOKUSHU_HAIDATE,
        },
            -- BOOTS AND GREAVES
        {
            xi.item.PURSUERS_GAITERS,
            xi.item.NAGA_KYAHAN,
            xi.item.ESCHITE_GREAVES,
            xi.item.PSYCLOTH_BOOTS,
            xi.item.RAWHIDE_BOOTS,
            xi.item.DESPAIR_GREAVES,
            xi.item.VANYA_CLOGS,
            xi.item.INSPIRITED_BOOTS,
            xi.item.TUTYR_SABOTS,
            xi.item.ODYSSEAN_GREAVES,
            xi.item.VALOROUS_GREAVES,
            xi.item.HERCULEAN_BOOTS,
            xi.item.MERLINIC_CRACKOWS,
            xi.item.CHIRONIC_SLIPPERS,
            xi.item.COMPOSERS_SABOTS,
            xi.item.AHOSI_LEGGINGS,
            xi.item.SKAOI_BOOTS,
            xi.item.NAVON_CRACKOWS,
            xi.item.SHUKUYU_SUNE_ATE,
        },
            -- NECK PIECES
        {
            xi.item.MARKED_GORGET,
            xi.item.SUBTLETY_SPECTACLES,
            xi.item.DAMPENERS_TORQUE,
            xi.item.EMPATH_NECKLACE,
            xi.item.RETI_PENDANT,
            xi.item.DIEMER_GORGET,
            xi.item.CARO_NECKLACE,
            xi.item.NODENS_GORGET,
            xi.item.CLOTHARIUS_TORQUE,
            xi.item.DEINO_COLLAR,
            xi.item.HOMERIC_GORGET,
            xi.item.AINIA_COLLAR,
            xi.item.JOKUSHU_CHAIN,
        },
            -- EARRINGS
        {
            xi.item.MENDICANTS_EARRING,
            xi.item.INFUSED_EARRING,
            xi.item.CALAMITOUS_EARRING,
            xi.item.HERMETIC_EARRING,
            xi.item.HALASZ_EARRING,
            xi.item.ASSUAGE_EARRING,
            xi.item.ISHVARA_EARRING,
            xi.item.EVANS_EARRING,
            xi.item.LEMPO_EARRING,
            xi.item.THUREOUS_EARRING,
            xi.item.DIGNITARYS_EARRING,
            xi.item.TELOS_EARRING,
            xi.item.GENMEI_EARRING,
        },
            -- BELTS AND SASHES
        {
            xi.item.LUCIDITY_SASH,
            xi.item.SINEW_BELT,
            xi.item.ESCHAN_STONE,
            xi.item.GRUNFELD_ROPE,
            xi.item.POROUS_ROPE,
            xi.item.SULLA_BELT,
            xi.item.YEMAYA_BELT,
            xi.item.CHANNELERS_STONE,
            xi.item.ASKLEPIAN_BELT,
            xi.item.SARISSAPHOROI_BELT,
            xi.item.LUMINARY_SASH,
            xi.item.KERYGMA_BELT,
            xi.item.REIKI_YOTAI,
            xi.item.KOBO_OBI,
        },
            -- RINGS
        {
            xi.item.OVERBEARING_RING,
            xi.item.RESONANCE_RING,
            xi.item.PURITY_RING,
            xi.item.WARDENS_RING,
            xi.item.PETROV_RING,
            xi.item.FORTIFIED_RING,
            xi.item.VERTIGO_RING,
            xi.item.EVANESCENCE_RING,
            xi.item.BEGRUDGING_RING,
            xi.item.APATE_RING,
            xi.item.PERSIS_RING,
            xi.item.HETAIROI_RING,
            xi.item.SHUKUYU_RING,
            xi.item.RAHAB_RING,
        },
            -- CAPES AND CLOAKS
        {
            xi.item.DISPERSERS_CAPE,
            xi.item.THAUMATURGES_CAPE,
            xi.item.PENETRATING_CAPE,
            xi.item.PHILIDOR_MANTLE,
            xi.item.SOKOLSKI_MANTLE,
            xi.item.QUARREL_MANTLE,
            xi.item.XUCAU_MANTLE,
            xi.item.TANTALIC_CAPE,
            xi.item.SCINTILLATING_CAPE,
            xi.item.PHALANGITE_MANTLE,
            xi.item.PERIMEDE_CAPE,
            xi.item.AGEMA_CAPE,
            xi.item.ENUMA_MANTLE,
            xi.item.REIKI_CLOAK,
        },
            -- OTHER
        {
            xi.item.SEKI_SHURIKEN_POUCH,
        },
    },

    -- Kupon A-OmII: Body pieces from Omen bosses (MOG_KUPON_A_OMII = 9169)
    [59] =
    {
        xi.item.DAGON_BREASTPLATE,
        xi.item.ASHERA_HARNESS,
        xi.item.SHAMASH_ROBE,
        xi.item.UDUG_JACKET,
        xi.item.NISHROCH_JERKIN,
    },

    -- Kupon I-AF119: Scale needed for the Reforged Artifact Armor +3 process (MOG_KUPON_I_AF119 = 9170)
    [60] =
    {
        xi.item.KINS_SCALE,
        xi.item.GINS_SCALE,
        xi.item.KEIS_SCALE,
        xi.item.KYOUS_SCALE,
        xi.item.FUS_SCALE,
    },

    -- Kupon AW-Om: Equipment pieces from Omen mid-bosses (MOG_KUPON_AW_OM = 9171)
    [61] =
    {
        xi.item.ENKI_STRAP,
        xi.item.KNOBKIERRIE,
        xi.item.ADAD_AMULET,
        xi.item.ANU_TORQUE,
        xi.item.ERRA_PENDANT,
        xi.item.SHERIDA_EARRING,
        xi.item.KISHAR_RING,
        xi.item.ADAPA_SHIELD,
        xi.item.NUSKU_SHIELD,
    },

    -- Kupon W-RMEA: iLevel 119 III Relic, Mythic, Empyrean or Aeonic Weapon (MOG_KUPON_W_RMEA = 9879)
    [62] =
    -- TODO: Implement and Apply Rank Augments
    {
            -- Relic
        {
            xi.item.SPHARAI_119_III,
            xi.item.MANDAU_119_III,
            xi.item.EXCALIBUR_119_III,
            xi.item.RAGNAROK_119_III,
            xi.item.GUTTLER_119_III,
            xi.item.BRAVURA_119_III,
            xi.item.APOCALYPSE_119_III,
            xi.item.GUNGNIR_119_III,
            xi.item.KIKOKU_119_III,
            xi.item.AMANOMURAKUMO_119_III,
            xi.item.MJOLLNIR_119_III,
            xi.item.CLAUSTRUM_119_III,
            { xi.item.YOICHINOYUMI_119_III_NO_QUIVER,  xi.item.YOICHIS_QUIVER             },
            { xi.item.ANNIHILATOR_119_III_NO_QUIVER,   xi.item.ERADICATING_BULLET_POUCH   },
        },
            -- Mythic
        {
            xi.item.GLANZFAUST_119_III,
            xi.item.KENKONKEN_119_III,
            xi.item.VAJRA_119_III,
            xi.item.CARNWENHAN_119_III,
            xi.item.TERPSICHORE_119_III,
            xi.item.MURGLEIS_119_III,
            xi.item.BURTGANG_119_III,
            xi.item.TIZONA_119_III,
            xi.item.AYMUR_119_III,
            xi.item.CONQUEROR_119_III,
            xi.item.LIBERATOR_119_III,
            xi.item.RYUNOHIGE_119_III,
            xi.item.NAGI_119_III,
            xi.item.KOGARASUMARU_119_III,
            xi.item.YAGRUSH_119_III,
            xi.item.LAEVATEINN_119_III,
            xi.item.NIRVANA_119_III,
            xi.item.TUPSIMATI_119_III,
            { xi.item.GASTRAPHETES_119_III_NO_QUIVER,  xi.item.QUELLING_BOLT_QUIVER   },
            { xi.item.DEATH_PENALTY_119_III_NO_QUIVER, xi.item.LIVING_BULLET_POUCH    },
        },
            -- Empyrean
        {
            xi.item.VERETHRAGNA_119_III,
            xi.item.TWASHTAR_119_III,
            xi.item.ALMACE_119_III,
            xi.item.CALADBOLG_119_III,
            xi.item.FARSHA_119_III,
            xi.item.UKONVASARA_119_III,
            xi.item.REDEMPTION_119_III,
            xi.item.RHONGOMIANT_119_III,
            xi.item.KANNAGI_119_III,
            xi.item.MASAMUNE_119_III,
            xi.item.GAMBANTEINN_119_III,
            xi.item.HVERGELMIR_119_III,
            { xi.item.GANDIVA_119_III_NO_QUIVER,       xi.item.ARTEMISS_QUIVER            },
            { xi.item.ARMAGEDDON_119_III_NO_QUIVER,    xi.item.DEVASTATING_BULLET_POUCH   },
        },
            -- Ergon
        {
            xi.item.IDRIS_119_II,
            xi.item.EPEOLATRY_119_II,
        },
            -- Aeonic
        {
            xi.item.GODHANDS,
            xi.item.AENEAS,
            xi.item.SEQUENCE,
            xi.item.LIONHEART,
            xi.item.TRI_EDGE,
            xi.item.CHANGO,
            xi.item.TRISHULA,
            xi.item.ANGUTA,
            xi.item.HEISHI_SHORINKEN,
            xi.item.DOJIKIRI_YASUTSUNA,
            xi.item.TISHTRYA,
            xi.item.KHATVANGA,
            { xi.item.FAIL_NOT_NO_QUIVER,              xi.item.CHRONO_QUIVER          },
            { xi.item.FOMALHAUT_NO_QUIVER,             xi.item.CHRONO_BULLET_POUCH    },
            xi.item.SRIVATSA,
            xi.item.MARSYAS,
        },
    }
}

local countKeyItems = function(player)
    local count = 0
    for _, v in pairs (kuponLookup) do
        local ki = v[1]
        if player:hasKeyItem(ki) then
            count = count + 1
        end
    end

    return count
end

local listToKeyItem = function(listID)
    for k, v in pairs (kuponLookup) do
        if v[2] == listID then
            return v[1]
        end
    end

    return nil
end

local buildMask = function(player, shift)
    local mask = 0
    local kiID = 0
    for k, v in pairs (kuponLookup) do
        if shift == 2 then
            if v[2] >= 32 and v[2] <= 62 then -- Mask 1 contains index 32 -> 62
                if player:hasKeyItem(v[1]) then
                    mask = mask + bit.lshift(shift, v[2])
                    kiID = v[2] -- Store the Key Item Index ID, used if there is only one KI found
                end
            end
        else
            if v[2] >= 1 and v[2] <= 31 then -- Mask 2 contains index 1 -> 31
                if player:hasKeyItem(v[1]) then
                    mask = mask + bit.lshift(shift, v[2])
                    kiID = v[2]
                end
            end
        end
    end

    return { mask, kiID } -- return both the completed mask and the kiID
end

local getIndexParams = function(list, option)
    local idxAlt1  = 0
    local idxAlt2  = 0
    local keyItems = 0

    if
        list == 12 or                   -- I-Seal
        list == 22 or                   -- AW-WK
        list == 26 or                   -- I-Skill
        (list >= 32 and list <= 34) or  -- AW-Mis / AW-Vgr / AW-VgrII
        (list >= 37 and list <= 41) or  -- AW-GFIII / AW-GFII / AW-GF / AW-UWIII / AW-UWII
        list == 44 or                   -- AW-Cos
        list == 47 or                   -- A-EMI
        list == 50 or                   -- A-SYW
        list == 53 or                   -- A-ASYW
        list == 58 or                   -- AW-GeIV
        list == 62                      -- W-RMEA
    then
        idxAlt1 = bit.rshift(option, 24)                -- Submenu ID
        idxAlt2 = bit.band(bit.rshift(option, 8), 0xFF) -- Item ID

        if list == 12 then
            idxAlt1 = bit.band(bit.rshift(option, 16), 0xFF)
        end
    end

    if list == 19 then -- List has keyitems
        keyItems = 1
    end

    return { idxAlt1, idxAlt2, keyItems }
end

local getItemSelection = function(player, list, idx, idxAlt1, idxAlt2)
    local item = 0

    if
        list == 12 or                   -- I-Seal
        list == 22 or                   -- AW-WK
        list == 26 or                   -- I-Skill
        (list >= 32 and list <= 34) or  -- AW-Mis / AW-Vgr / AW-VgrII
        (list >= 37 and list <= 41) or  -- AW-GFIII / AW-GFII / AW-GF / AW-UWIII / AW-UWII
        list == 47 or                   -- A-EMI
        list == 50 or                   -- A-SYW
        list == 53 or                   -- A-ASYW
        list == 58 or                   -- AW-GeIV
        list == 62                      -- W-RMEA
    then
        if debug.ENABLED and not debug.SHOWITEM then
            item = 0
        else
            item = itemList[list][idxAlt1][idxAlt2]
        end

        if list == 12 then  -- Item, Quantity
            item = { item } -- Tabling here to save 100 pairs of { }
        end
    elseif
        list == 44 -- AW-Cos (Index Defaults to Female itemID, CS will automatically swap items based on gender)
    then
        local gender    = player:getGender()                        -- Female: 0, Male: 1
        local itemID    = itemList[list][idxAlt1][idxAlt2][1]       -- Extract the base itemID (F) from the index
        local modifier  = itemList[list][idxAlt1][idxAlt2][2] or 0  -- Extract the base shift value from the index (typically 1 or 2)

        item = itemID - (gender * modifier) -- Generate the actual itemID by subtracting the shift value from the base itemID
    else
        item = itemList[list][idx]
    end

    return item
end

local debugInfo = function(player, item, list, option, altIDs, idx)
    local ID        = zones[player:getZoneID()]
    local idxAlt1   = altIDs[1]
    local idxAlt2   = altIDs[2]
    local keyitem   = altIDs[3]

    if debug.SHOWITEM then
        if keyitem == 0 then
            player:messageSpecial(ID.text.ITEM_OBTAINED, item)
        else
            player:messageSpecial(xi.msg.basic.KEYITEM_OBTAINED, item)
        end
    end

    if debug.TO_PLAYER then
        player:PrintToPlayer(string.format('DEBUG: list: %u, idx: %u, submenuid %u, slot: %u', list, idx, idxAlt1, idxAlt2), xi.msg.channel.SYSTEM_3)
    else
        print(string.format('DEBUG: list: %u, idx: %u, submenuid %u, slot: %u', list, idx, idxAlt1, idxAlt2))
    end
end

xi.dealerMoogle.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    if trade:getItemCount() > 1 then
        return -- Prevent accidental trade of stacks (first vana'diel problems, kupo!)
    end

    if not kuponLookup[itemID] then
        return
    end

    local zoneID = player:getZoneID()
    local csid   = csidLookup[zoneID][2]
    local kiID   = kuponLookup[itemID][1]
    local listID = kuponLookup[itemID][2]

    -- Trade Item (itemID) will only be consumed if the player does not yet have the corresponding KI. It will be replaced with a
    -- key item version! No need to tell the player, the CS handles all of the messaging. If the Player already has the Key Item,
    -- the itemID will not be consumed, but the Key Item will only be consumed upon completing a successful transaction.

    -- Scenario 1:  Player trades the item, but does NOT already have the corresponding Key Item. The trade is consumed. Player will
    --              either receive the item(s) of their choice or they will receive the corresponding Key Item if they back out of
    --              the menu without completing a transaction. In actuality, the Key Item is added silently as soon as the trade
    --              occurs, and deleted only if the player completes the transaction. This is to prevent the player from losing
    --              access to the reward in the event of a disconnect mid-transaction.

    -- Scenario 2:  Player trades the item and DOES already have the corresponding Key Item. The CS menu will present as if the player
    --              triggered the dealer while in posession of the Key Item. If the player completes the transaction, they will receive
    --              the item(s) of their choice, the Key Item will be consumed, the traded item will not be consumed. If the player does
    --              not complete the transaction, they will retain both the traded Item and Key Item.

    if player:hasItem(itemID) then
        if player:hasKeyItem(kiID) then -- Player already has the KI for the traded item. Present the KI version of the CS, consume the KI only if transaction completes.
            player:startEvent(csid, itemID, kiID, listID, 1)
        else -- Player doesn't have the KI corresponding to the item. Consume the item on trade and convert to Key Item immediately.
            trade:confirmItem(itemID, 1)
            player:confirmTrade()
            player:addKeyItem(kiID)

            player:startEvent(csid, itemID, kiID, listID)
        end
    end
end

xi.dealerMoogle.onTrigger = function(player, npc)
    local zoneID = player:getZoneID()
    local cs     = csidLookup[zoneID][2]
    local numKIs = countKeyItems(player)
    local mask1  = buildMask(player, 2)[1]
    local mask2  = buildMask(player, 1)[1]
    local kiID   = buildMask(player, 2)[2] + buildMask(player, 1)[2]

    if numKIs < 1 then -- play default CS if no KIs found
        cs = csidLookup[zoneID][1]
    end

    -- Capture of multiple stored KIs: CS2: 0, 0, 51, 4, 0, 0, 1843200, 0

    player:startEvent(cs, 0, 0, kiID, numKIs, 0, 0, mask1, mask2)
end

xi.dealerMoogle.onEventUpdate = function(player, csid, option, npc)
    -- print('update', csid, option)
end

xi.dealerMoogle.onEventFinish = function(player, csid, option, npc)
    -- print('finish', csid, option)
    if option == 0 then
        return
    end

    local zoneID = player:getZoneID()
    local itemCsid = csidLookup[zoneID][2]

    if csid == itemCsid then
        local list      = bit.band(option, 0xFF)
        local idx       = bit.rshift(option, 8)
        local altIDs    = getIndexParams(list, option)
        local idxAlt1   = altIDs[1]
        local idxAlt2   = altIDs[2]
        local keyItems  = altIDs[3]

        if list > 0 and idx == 0 then
            player:addKeyItem(listToKeyItem(list))
        elseif list > 0 and idx > 0 then
            local item = getItemSelection(player, list, idx, idxAlt1, idxAlt2)

            if debug.ENABLED then
                debugInfo(player, item, list, option, altIDs, idx)
            else
                if keyItems == 0 then
                    if npcUtil.giveItem(player, item) then
                        player:delKeyItem(listToKeyItem(list))
                    else
                        -- TODO: CS Messaging that getting the item has failed
                    end
                else
                    if not player:hasKeyItem(item) then
                        npcUtil.giveKeyItem(player, item)
                        player:delKeyItem(listToKeyItem(list))
                    else
                        player:messageBasic(xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, item)
                        -- TODO: CS Messaging that getting the item has failed
                    end
                end
            end
        end
    end
end
