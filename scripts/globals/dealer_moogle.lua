-----------------------------------
-- Dealer Moogles & Kupon Global
-- https://www.bg-wiki.com/ffxi/Category:Mog_Bonanza
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.dealerMoogle = xi.dealerMoogle or {}

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
    [xi.items.MOG_KUPON_A_DBCD   ] = { xi.ki.MOG_KUPON_A_DBCD,    1 },
    [xi.items.MOG_KUPON_A_DXAR   ] = { xi.ki.MOG_KUPON_A_DXAR,    2 },
    [xi.items.MOG_KUPON_AW_ABS   ] = { xi.ki.MOG_KUPON_AW_ABS,    3 },
    [xi.items.MOG_KUPON_AW_PAN   ] = { xi.ki.MOG_KUPON_AW_PAN,    4 },
    [xi.items.MOG_KUPON_A_LUM    ] = { xi.ki.MOG_KUPON_A_LUM,     5 },
    [xi.items.MOG_KUPON_W_E85    ] = { xi.ki.MOG_KUPON_W_E85,     6 },
    [xi.items.MOG_KUPON_A_RJOB   ] = { xi.ki.MOG_KUPON_A_RJOB,    7 },
    [xi.items.MOG_KUPON_W_R90    ] = { xi.ki.MOG_KUPON_W_R90,     8 },
    [xi.items.MOG_KUPON_W_M90    ] = { xi.ki.MOG_KUPON_W_M90,     9 },
    [xi.items.MOG_KUPON_W_E90    ] = { xi.ki.MOG_KUPON_W_E90,    10 },
    [xi.items.MOG_KUPON_A_E2     ] = { xi.ki.MOG_KUPON_A_E2,     11 },
    [xi.items.MOG_KUPON_I_SEAL   ] = { xi.ki.MOG_KUPON_I_SEAL,   12 },
    [xi.items.MOG_KUPON_A_DEII   ] = { xi.ki.MOG_KUPON_A_DEII,   13 },
    [xi.items.MOG_KUPON_A_DE     ] = { xi.ki.MOG_KUPON_A_DE,     14 },
    [xi.items.MOG_KUPON_A_SAL    ] = { xi.ki.MOG_KUPON_A_SAL,    15 },
    [xi.items.MOG_KUPON_A_NYZ    ] = { xi.ki.MOG_KUPON_A_NYZ,    16 },
    [xi.items.MOG_KUPON_I_S5     ] = { xi.ki.MOG_KUPON_I_S5,     17 },
    [xi.items.MOG_KUPON_I_S2     ] = { xi.ki.MOG_KUPON_I_S2,     18 },
    [xi.items.MOG_KUPON_I_ORCHE  ] = { xi.ki.MOG_KUPON_I_ORCHE,  19 },
    [xi.items.MOG_KUPON_I_AF109  ] = { xi.ki.MOG_KUPON_I_AF109,  20 },
    [xi.items.MOG_KUPON_W_EWS    ] = { xi.ki.MOG_KUPON_W_EWS,    21 },
    [xi.items.MOG_KUPON_AW_WK    ] = { xi.ki.MOG_KUPON_AW_WK,    22 },
    [xi.items.MOG_KUPON_I_S3     ] = { xi.ki.MOG_KUPON_I_S3,     23 },
    [xi.items.MOG_KUPON_A_PK109  ] = { xi.ki.MOG_KUPON_A_PK109,  24 },
    [xi.items.MOG_KUPON_I_S1     ] = { xi.ki.MOG_KUPON_I_S1,     25 },
    [xi.items.MOG_KUPON_I_SKILL  ] = { xi.ki.MOG_KUPON_I_SKILL,  26 },
    [xi.items.MOG_KUPON_I_RME    ] = { xi.ki.MOG_KUPON_I_RME,    27 },
--  [xi.items.NOT_IN_USE         ] = { xi.ki.MOG_KUPON_I,        28 },
    [xi.items.MOG_KUPON_W_JOB    ] = { xi.ki.MOG_KUPON_W_JOB,    29 },
    [xi.items.MOG_KUPON_I_MAT    ] = { xi.ki.MOG_KUPON_I_MAT,    30 },
    [xi.items.MOG_KUPON_W_DEIII  ] = { xi.ki.MOG_KUPON_W_DEIII,  31 },
    [xi.items.MOG_KUPON_AW_MIS   ] = { xi.ki.MOG_KUPON_AW_MIS,   32 },
    [xi.items.MOG_KUPON_AW_VGR   ] = { xi.ki.MOG_KUPON_AW_VGR,   33 },
    [xi.items.MOG_KUPON_AW_VGRII ] = { xi.ki.MOG_KUPON_AW_VGRII, 34 },
    [xi.items.MOG_KUPON_W_PULSE  ] = { xi.ki.MOG_KUPON_W_PULSE,  35 },
    [xi.items.MOG_KUPON_I_STONE  ] = { xi.ki.MOG_KUPON_I_STONE,  36 },
    [xi.items.MOG_KUPON_AW_GFIII ] = { xi.ki.MOG_KUPON_AW_GFIII, 37 },
    [xi.items.MOG_KUPON_AW_GFII  ] = { xi.ki.MOG_KUPON_AW_GFII,  38 },
    [xi.items.MOG_KUPON_AW_GF    ] = { xi.ki.MOG_KUPON_AW_GF,    39 },
    [xi.items.MOG_KUPON_AW_UWIII ] = { xi.ki.MOG_KUPON_AW_UWIII, 40 },
    [xi.items.MOG_KUPON_AW_UWII  ] = { xi.ki.MOG_KUPON_AW_UWII,  41 },
    [xi.items.MOG_KUPON_AW_UW    ] = { xi.ki.MOG_KUPON_AW_UW,    42 },
    [xi.items.MOG_KUPON_A_AB     ] = { xi.ki.MOG_KUPON_A_AB,     43 },
    [xi.items.MOG_KUPON_AW_COS   ] = { xi.ki.MOG_KUPON_AW_COS,   44 },
    [xi.items.MOG_KUPON_AW_KUPO  ] = { xi.ki.MOG_KUPON_AW_KUPO,  45 },
    [xi.items.MOG_KUPON_W_EMI    ] = { xi.ki.MOG_KUPON_W_EMI,    46 },
    [xi.items.MOG_KUPON_A_EMI    ] = { xi.ki.MOG_KUPON_A_EMI,    47 },
    [xi.items.MOG_KUPON_W_SRW    ] = { xi.ki.MOG_KUPON_W_SRW,    48 },
    [xi.items.MOG_KUPON_W_SCC    ] = { xi.ki.MOG_KUPON_W_SCC,    49 },
    [xi.items.MOG_KUPON_A_SYW    ] = { xi.ki.MOG_KUPON_A_SYW,    50 },
    [xi.items.MOG_KUPON_W_ASRW   ] = { xi.ki.MOG_KUPON_W_ASRW,   51 },
    [xi.items.MOG_KUPON_W_ASCC   ] = { xi.ki.MOG_KUPON_W_ASCC,   52 },
    [xi.items.MOG_KUPON_A_ASYW   ] = { xi.ki.MOG_KUPON_A_ASYW,   53 },
    [xi.items.MOG_KUPON_W_R119   ] = { xi.ki.MOG_KUPON_W_R119,   54 },
    [xi.items.MOG_KUPON_W_M119   ] = { xi.ki.MOG_KUPON_W_M119,   55 },
    [xi.items.MOG_KUPON_W_E119   ] = { xi.ki.MOG_KUPON_W_E119,   56 },
    [xi.items.MOG_KUPON_W_A119   ] = { xi.ki.MOG_KUPON_W_A119,   57 },
    [xi.items.MOG_KUPON_AW_GEIV  ] = { xi.ki.MOG_KUPON_AW_GEIV,  58 },
    [xi.items.MOG_KUPON_A_OMII   ] = { xi.ki.MOG_KUPON_A_OMII,   59 },
    [xi.items.MOG_KUPON_I_AF119  ] = { xi.ki.MOG_KUPON_I_AF119,  60 },
    [xi.items.MOG_KUPON_AW_OM    ] = { xi.ki.MOG_KUPON_AW_OM,    61 },
    [xi.items.MOG_KUPON_W_RMEA   ] = { xi.ki.MOG_KUPON_W_RMEA,   62 },
--  [xi.items.NEXT_POTENTIAL_ID  ] = { xi.ki.NEXT_POTENTIAL_ID,  63 },

}

-- WARNING!!! These items cannot be customised, and must be in the order
-- they appear in the in-game menus! Everything is dictated by the client!
local itemList =
{
    -- Kupon A-DBcd: Dynamis - Beaucedine (MOG_KUPON_A_DBCD = 2745)
    [1] =
    {
        xi.items.WARRIORS_CUISSES,
        xi.items.MELEE_CYCLAS,
        xi.items.CLERICS_BRIAULT,
        xi.items.SORCERERS_COAT,
        xi.items.DUELISTS_TABARD,
        xi.items.ASSASSINS_CULOTTES,
        xi.items.VALOR_BREECHES,
        xi.items.ABYSS_CUIRASS,
        xi.items.MONSTER_GAITERS,
        xi.items.BARDS_JUSTAUCORPS,
        xi.items.SCOUTS_SOCKS,
        xi.items.SAOTOME_DOMARU,
        xi.items.KOGA_CHAINMAIL,
        xi.items.WYRM_MAIL,
        xi.items.SUMMONERS_DOUBLET,
        xi.items.MIRAGE_JUBBAH,
        xi.items.COMMODORE_FRAC,
        xi.items.PANTIN_TOBE,
        xi.items.ETOILE_TIGHTS,
        xi.items.ARGUTE_GOWN,
    },

    -- Kupon A-DXar: Dynamis - Xarcabard (MOG_KUPON_A_DXAR = 2746)
    [2] =
    {
        xi.items.WARRIORS_LORICA,
        xi.items.MELEE_CROWN,
        xi.items.CLERICS_MITTS,
        xi.items.SORCERERS_PETASOS,
        xi.items.DUELISTS_CHAPEAU,
        xi.items.ASSASSINS_ARMLETS,
        xi.items.VALOR_SURCOAT,
        xi.items.ABYSS_BURGEONET,
        xi.items.MONSTER_GLOVES,
        xi.items.BARDS_CANNIONS,
        xi.items.SCOUTS_JERKIN,
        xi.items.SAOTOME_KABUTO,
        xi.items.KOGA_TEKKO,
        xi.items.WYRM_ARMET,
        xi.items.SUMMONERS_HORN,
        xi.items.MIRAGE_KEFFIYEH,
        xi.items.COMMODORE_TRICORNE,
        xi.items.PANTIN_TAJ,
        xi.items.ETOILE_CASAQUE,
        xi.items.ARGUTE_MORTARBOARD,
    },

    -- Kupon AW-Abs: Absolute Virtue (MOG_KUPON_AW_ABS = 2802)
    [3] =
    {
        xi.items.NINURTAS_SASH,
        xi.items.MARSS_RING,
        xi.items.BELLONAS_RING,
        xi.items.MINERVAS_RING,
        xi.items.FUTSUNO_MITAMA,
        xi.items.AUREOLE,
        xi.items.RAPHAELS_ROD,
    },

    -- Kupon AW-Pan: Pandemonium Warden (MOG_KUPON_AW_PAN = 2801)
    [4] =
    {
        xi.items.HACHIRYU_HARAMAKI,
        xi.items.NANATSUSAYA,
        xi.items.DORJE,
        xi.items.SHENLONGS_BAGHNAKHS,
    },

    -- Kupon A-Lum: Sea NM System (MOG_KUPON_A_LUM = 2736)
    [5] =
    {
        xi.items.JUSTICE_TORQUE,
        xi.items.HOPE_TORQUE,
        xi.items.PRUDENCE_TORQUE,
        xi.items.FORTITUDE_TORQUE,
        xi.items.FAITH_TORQUE,
        xi.items.TEMPERANCE_TORQUE,
        xi.items.LOVE_TORQUE,
        xi.items.MERCIFUL_CAPE,
        xi.items.ALTRUISTIC_CAPE,
        xi.items.ASTUTE_CAPE,
    },

    -- Kupon W-E85: Lv85 Empyrean Weapons (MOG_KUPON_W_E85 = 2958)
    [6] =
    {
        xi.items.VERETHRAGNA_85,
        xi.items.TWASHTAR_85,
        xi.items.ALMACE_85,
        xi.items.CALADBOLG_85,
        xi.items.FARSHA_85,
        xi.items.UKONVASARA_85,
        xi.items.REDEMPTION_85,
        xi.items.RHONGOMIANT_85,
        xi.items.KANNAGI_85,
        xi.items.MASAMUNE_85,
        xi.items.GAMBANTEINN_85,
        xi.items.HVERGELMIR_85,
        xi.items.GANDIVA_85,
        xi.items.ARMAGEDDON_85,
    },

    -- Kupon A-RJob: Lv70 Relic Armor Accessories (MOG_KUPON_A_RJOB = 2959)
    [7] =
    {
        xi.items.WARRIORS_STONE,
        xi.items.MELEE_CAPE,
        xi.items.CLERICS_BELT,
        xi.items.SORCERERS_BELT,
        xi.items.DUELISTS_BELT,
        xi.items.ASSASSINS_CAPE,
        xi.items.VALOR_CAPE,
        xi.items.ABYSS_CAPE,
        xi.items.MONSTER_BELT,
        xi.items.BARDS_CAPE,
        xi.items.SCOUTS_BELT,
        xi.items.SAOTOME_KOSHI_ATE,
        xi.items.KOGA_SARASHI,
        xi.items.WYRM_BELT,
        xi.items.SUMMONERS_CAPE,
        xi.items.MIRAGE_MANTLE,
        xi.items.COMMODORE_BELT,
        xi.items.PANTIN_CAPE,
        xi.items.ETOILE_CAPE,
        xi.items.ARGUTE_BELT,
    },

    -- Kupon W-R90: Lv90 Relic Weapons and upgrade materials (MOG_KUPON_W_R90 = 3438)
    [8] =
    {
        { xi.items.AEGIS_90,            { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }                           },
        { xi.items.GJALLARHORN_90,      { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }                           },
        { xi.items.SPHARAI_90,          { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.MANDAU_90,           { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.EXCALIBUR_90,        { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.RAGNAROK_90,         { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.GUTTLER_90,          { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.BRAVURA_90,          { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.GUGNIR_90,           { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.APOCALYPSE_90,       { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.KIKOKU_90,           { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.AMANOMURAKUMO_90,    { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.MJOLLNIR_90,         { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.CLAUSTRUM_90,        { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.ANNIHILATOR_90,      { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
        { xi.items.YOICHINOYUMI_90,     { xi.items.VIAL_OF_UMBRAL_MARROW, 5 }, { xi.items.PLUTON, 300 } },
    },

    -- Kupon W-M90: Lv90 Mythic Weapons (MOG_KUPON_W_M90 = 3439)
    [9] =
    {
        { xi.items.CONQUEROR_90,        { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.GLANZFAUST_90,       { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.YAGRUSH_90,          { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.LAEVATEINN_90,       { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.MURGLEIS_90,         { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.VAJRA_90,            { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.BURTGANG_90,         { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.LIBERATOR_90,        { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.AYMUR_90,            { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.CARNWENHAN_90,       { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.GASTRAPHETES_90,     { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.KOGARASUMARU_90,     { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.NAGI_90,             { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.RYUNOHIGE_90,        { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.NIRVANA_90,          { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.TIZONA_90,           { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.DEATH_PENALTY_90,    { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.KENKONKEN_90,        { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.TERPSICHORE_90,      { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
        { xi.items.TUPSIMATI_90,        { xi.items.MULCIBARS_SCORIA, 3 }, { xi.items.BEITETSU, 300 } },
    },

    -- Kupon W-E90: Lv90 Empyrean Weapons (MOG_KUPON_W_E90 = 3440)
    [10] =
    {
        { xi.items.VERETHRAGNA_90,  xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.TWASHTAR_90,     xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.ALMACE_90,       xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.CALADBOLG_90,    xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.FARSHA_90,       xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.UKONVASARA_90,   xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.REDEMPTION_90,   xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.RHONGOMIANT_90,  xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.KANNAGI_90,      xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.MASAMUNE_90,     xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.GAMBANTEINN_90,  xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.HVERGELMIR_90,   xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.GANDIVA_90,      xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.ARMAGEDDON_90,   xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.DAURDABLA_90,    xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 },                                    },
        { xi.items.OCHAIN_90,       xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 },                                    },
    },

    -- Kupon A-E+2: Empyrean Armor +2 (MOG_KUPON_A_E2 = 3441)
    [11] =
    {
        { xi.items.RAVAGERS_MASK_P2,        xi.items.RAVAGERS_LORICA_P2,    xi.items.RAVAGERS_MUFFLERS_P2,      xi.items.RAVAGERS_CUISSES_P2,   xi.items.RAVAGERS_CALLIGAE_P2   },
        { xi.items.TANTRA_CROWN_P2,         xi.items.TANTRA_CYCLAS_P2,      xi.items.TANTRA_GLOVES_P2,          xi.items.TANTRA_HOSE_P2,        xi.items.TANTRA_GAITERS_P2      },
        { xi.items.ORISON_CAP_P2,           xi.items.ORISON_BLIAUD_P2,      xi.items.ORISON_MITTS_P2,           xi.items.ORISON_PANTALOONS_P2,  xi.items.ORISON_DUCKBILLS_P2    },
        { xi.items.GOETIA_PETASOS_P2,       xi.items.GOETIA_COAT_P2,        xi.items.GOETIA_GLOVES_P2,          xi.items.GOETIA_CHAUSSES_P2,    xi.items.GOETIA_SABOTS_P2       },
        { xi.items.ESTOQUEURS_CHAPPEL_P2,   xi.items.ESTOQUEURS_SAYON_P2,   xi.items.ESTOQUEURS_GANTHEROTS_P2,  xi.items.ESTOQUEURS_FUSEAU_P2,  xi.items.ESTOQUEURS_HOUSEAUX_P2 },
        { xi.items.RAIDERS_BONNET_P2,       xi.items.RAIDERS_VEST_P2,       xi.items.RAIDERS_ARMLETS_P2,        xi.items.RAIDERS_CULOTTES_P2,   xi.items.RAIDERS_POULAINES_P2   },
        { xi.items.CREED_ARMET_P2,          xi.items.CREED_CUIRASS_P2,      xi.items.CREED_GAUNTLETS_P2,        xi.items.CREED_CUISSES_P2,      xi.items.CREED_SABATONS_P2      },
        { xi.items.BALE_BURGEONET_P2,       xi.items.BALE_CUIRASS_P2,       xi.items.BALE_GAUNTLETS_P2,         xi.items.BALE_FLANCHARD_P2,     xi.items.BALE_SOLLERETS_P2      },
        { xi.items.FERINE_CABASSET_P2,      xi.items.FERINE_GAUSAPE_P2,     xi.items.FERINE_MANOPLAS_P2,        xi.items.FERINE_QUIJOTES_P2,    xi.items.FERINE_OCREAE_P2       },
        { xi.items.AOIDOS_CALOT_P2,         xi.items.AOIDOS_HONGRELINE_P2,  xi.items.AOIDOS_MANCHETTES_P2,      xi.items.AOIDOS_RHINGRAVE_P2,   xi.items.AOIDOS_COTHURNES_P2    },
        { xi.items.SYLVAN_GAPETTE_P2,       xi.items.SYLVAN_CABAN_P2,       xi.items.SYLVAN_GLOVELETTES_P2,     xi.items.SYLVAN_BRAGUES_P2,     xi.items.SYLVAN_BOTTILLONS_P2   },
        { xi.items.UNKAI_KABUTO_P2,         xi.items.UNKAI_DOMARU_P2,       xi.items.UNKAI_KOTE_P2,             xi.items.UNKAI_HAIDATE_P2,      xi.items.UNKAI_SUNE_ATE_P2      },
        { xi.items.IGA_ZUKIN_P2,            xi.items.IGA_NINGI_P2,          xi.items.IGA_TEKKO_P2,              xi.items.IGA_HAKAMA_P2,         xi.items.IGA_KYAHAN_P2          },
        { xi.items.LANCERS_MEZAIL_P2,       xi.items.LANCERS_PLACKART_P2,   xi.items.LANCERS_VAMBRACES_P2,      xi.items.LANCERS_CUISSOTS_P2,   xi.items.LANCERS_SCHYNBALDS_P2  },
        { xi.items.CALLERS_HORN_P2,         xi.items.CALLERS_DOUBLET_P2,    xi.items.CALLERS_BRACERS_P2,        xi.items.CALLERS_SPATS_P2,      xi.items.CALLERS_PIGACHES_P2    },
        { xi.items.MAVI_KAVUK_P2,           xi.items.MAVI_MINTAN_P2,        xi.items.MAVI_BAZUBANDS_P2,         xi.items.MAVI_TAYT_P2,          xi.items.MAVI_BASMAK_P2         },
        { xi.items.NAVARCHS_TRICORNE_P2,    xi.items.NAVARCHS_FRAC_P2,      xi.items.NAVARCHS_GANTS_P2,         xi.items.NAVARCHS_CULOTTES_P2,  xi.items.NAVARCHS_BOTTES_P2     },
        { xi.items.CIRQUE_CAPPELLO_P2,      xi.items.CIRQUE_FARSETTO_P2,    xi.items.CIRQUE_GUANTI_P2,          xi.items.CIRQUE_PANTALONI_P2,   xi.items.CIRQUE_SCARPE_P2       },
        { xi.items.CHARIS_TIARA_P2,         xi.items.CHARIS_CASAQUE_P2,     xi.items.CHARIS_BANGLES_P2,         xi.items.CHARIS_TIGHTS_P2,      xi.items.CHARIS_TOE_SHOES_P2    },
        { xi.items.SAVANTS_BONNET_P2,       xi.items.SAVANTS_GOWN_P2,       xi.items.SAVANTS_BRACERS_P2,        xi.items.SAVANTS_PANTS_P2,      xi.items.SAVANTS_LOAFERS_P2     },
    },
    -- Kupon I-Seal: 10 (Body) or 8 (other) of any One Empyrean Armor upgrade seals (MOG_KUPON_I_SEAL = 3442)
    [12] =
    {-- List 12 uses submenus and requires different table formatting to address each { itemid, qty } pairing. Item = List[12][Job][Slot]
        { { xi.items.RAVAGERS_SEAL_HEAD,   8 }, { xi.items.RAVAGERS_SEAL_BODY,   10 }, { xi.items.RAVAGERS_SEAL_HANDS,   8 }, { xi.items.RAVAGERS_SEAL_LEGS,   8 }, { xi.items.RAVAGERS_SEAL_FEET,   8 } },
        { { xi.items.TANTRA_SEAL_HEAD,     8 }, { xi.items.TANTRA_SEAL_BODY,     10 }, { xi.items.TANTRA_SEAL_HANDS,     8 }, { xi.items.TANTRA_SEAL_LEGS,     8 }, { xi.items.TANTRA_SEAL_FEET,     8 } },
        { { xi.items.ORISON_SEAL_HEAD,     8 }, { xi.items.ORISON_SEAL_BODY,     10 }, { xi.items.ORISON_SEAL_HANDS,     8 }, { xi.items.ORISON_SEAL_LEGS,     8 }, { xi.items.ORISON_SEAL_FEET,     8 } },
        { { xi.items.GOETIA_SEAL_HEAD,     8 }, { xi.items.GOETIA_SEAL_BODY,     10 }, { xi.items.GOETIA_SEAL_HANDS,     8 }, { xi.items.GOETIA_SEAL_LEGS,     8 }, { xi.items.GOETIA_SEAL_FEET,     8 } },
        { { xi.items.ESTOQUEURS_SEAL_HEAD, 8 }, { xi.items.ESTOQUEURS_SEAL_BODY, 10 }, { xi.items.ESTOQUEURS_SEAL_HANDS, 8 }, { xi.items.ESTOQUEURS_SEAL_LEGS, 8 }, { xi.items.ESTOQUEURS_SEAL_FEET, 8 } },
        { { xi.items.RAIDERS_SEAL_HEAD,    8 }, { xi.items.RAIDERS_SEAL_BODY,    10 }, { xi.items.RAIDERS_SEAL_HANDS,    8 }, { xi.items.RAIDERS_SEAL_LEGS,    8 }, { xi.items.RAIDERS_SEAL_FEET,    8 } },
        { { xi.items.CREED_SEAL_HEAD,      8 }, { xi.items.CREED_SEAL_BODY,      10 }, { xi.items.CREED_SEAL_HANDS,      8 }, { xi.items.CREED_SEAL_LEGS,      8 }, { xi.items.CREED_SEAL_FEET,      8 } },
        { { xi.items.BALE_SEAL_HEAD,       8 }, { xi.items.BALE_SEAL_BODY,       10 }, { xi.items.BALE_SEAL_HANDS,       8 }, { xi.items.BALE_SEAL_LEGS,       8 }, { xi.items.BALE_SEAL_FEET,       8 } },
        { { xi.items.FERINE_SEAL_HEAD,     8 }, { xi.items.FERINE_SEAL_BODY,     10 }, { xi.items.FERINE_SEAL_HANDS,     8 }, { xi.items.FERINE_SEAL_LEGS,     8 }, { xi.items.FERINE_SEAL_FEET,     8 } },
        { { xi.items.AOIDOS_SEAL_HEAD,     8 }, { xi.items.AOIDOS_SEAL_BODY,     10 }, { xi.items.AOIDOS_SEAL_HANDS,     8 }, { xi.items.AOIDOS_SEAL_LEGS,     8 }, { xi.items.AOIDOS_SEAL_FEET,     8 } },
        { { xi.items.SYLVAN_SEAL_HEAD,     8 }, { xi.items.SYLVAN_SEAL_BODY,     10 }, { xi.items.SYLVAN_SEAL_HANDS,     8 }, { xi.items.SYLVAN_SEAL_LEGS,     8 }, { xi.items.SYLVAN_SEAL_FEET,     8 } },
        { { xi.items.UNKAI_SEAL_HEAD,      8 }, { xi.items.UNKAI_SEAL_BODY,      10 }, { xi.items.UNKAI_SEAL_HANDS,      8 }, { xi.items.UNKAI_SEAL_LEGS,      8 }, { xi.items.UNKAI_SEAL_FEET,      8 } },
        { { xi.items.IGA_SEAL_HEAD,        8 }, { xi.items.IGA_SEAL_BODY,        10 }, { xi.items.IGA_SEAL_HANDS,        8 }, { xi.items.IGA_SEAL_LEGS,        8 }, { xi.items.IGA_SEAL_FEET,        8 } },
        { { xi.items.LANCERS_SEAL_HEAD,    8 }, { xi.items.LANCERS_SEAL_BODY,    10 }, { xi.items.LANCERS_SEAL_HANDS,    8 }, { xi.items.LANCERS_SEAL_LEGS,    8 }, { xi.items.LANCERS_SEAL_FEET,    8 } },
        { { xi.items.CALLERS_SEAL_HEAD,    8 }, { xi.items.CALLERS_SEAL_BODY,    10 }, { xi.items.CALLERS_SEAL_HANDS,    8 }, { xi.items.CALLERS_SEAL_LEGS,    8 }, { xi.items.CALLERS_SEAL_FEET,    8 } },
        { { xi.items.MAVI_SEAL_HEAD,       8 }, { xi.items.MAVI_SEAL_BODY,       10 }, { xi.items.MAVI_SEAL_HANDS,       8 }, { xi.items.MAVI_SEAL_LEGS,       8 }, { xi.items.MAVI_SEAL_FEET,       8 } },
        { { xi.items.NAVARCHS_SEAL_HEAD,   8 }, { xi.items.NAVARCHS_SEAL_BODY,   10 }, { xi.items.NAVARCHS_SEAL_HANDS,   8 }, { xi.items.NAVARCHS_SEAL_LEGS,   8 }, { xi.items.NAVARCHS_SEAL_FEET,   8 } },
        { { xi.items.CIRQUE_SEAL_HEAD,     8 }, { xi.items.CIRQUE_SEAL_BODY,     10 }, { xi.items.CIRQUE_SEAL_HANDS,     8 }, { xi.items.CIRQUE_SEAL_LEGS,     8 }, { xi.items.CIRQUE_SEAL_FEET,     8 } },
        { { xi.items.CHARIS_SEAL_HEAD,     8 }, { xi.items.CHARIS_SEAL_BODY,     10 }, { xi.items.CHARIS_SEAL_HANDS,     8 }, { xi.items.CHARIS_SEAL_LEGS,     8 }, { xi.items.CHARIS_SEAL_FEET,     8 } },
        { { xi.items.SAVANTS_SEAL_HEAD,    8 }, { xi.items.SAVANTS_SEAL_BODY,    10 }, { xi.items.SAVANTS_SEAL_HANDS,    8 }, { xi.items.SAVANTS_SEAL_LEGS,    8 }, { xi.items.SAVANTS_SEAL_FEET,    8 } },
    },
    -- Kupon A-DeII: Delve boss armor pieces (MOG_KUPON_A_DEII = 3967)
    [13] =
    {
        xi.items.YAOYOTL_HELM,
        xi.items.YAOYOTL_GLOVES,
        xi.items.WHIRLPOOL_MASK,
        xi.items.WHIRLPOOL_GREAVES,
        xi.items.NAHTIRAH_HAT,
        xi.items.NAHTIRAH_TROUSERS,
        xi.items.UMBANI_CAP,
        xi.items.UMBANI_BOOTS,
        xi.items.UMUTHI_HAT,
        xi.items.UMUTHI_GLOVES,
        xi.items.IGHWA_CAP,
        xi.items.IGHWA_TROUSERS,
    },

    -- Kupon A-De: Delve field armor pieces (MOG_KUPON_A_DE = 3968)
    [14] =
    {
        { xi.items.MIKINAAK_HELM,           { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.MIKINAAK_BREASTPLATE,    { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.MIKINAAK_GAUNTLETS,      { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.MIKINAAK_CUISSES,        { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.MIKINAAK_GREAVES,        { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.MANIBOZHO_BERET,         { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.MANIBOZHO_JERKIN,        { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.MANIBOZHO_GLOVES,        { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.MANIBOZHO_BRAIS,         { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.MANIBOZHO_BOOTS,         { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.BOKWUS_CIRCLET,          { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.BOKWUS_ROBE,             { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.BOKWUS_GLOVES,           { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.BOKWUS_SLOPS,            { xi.items.AIRLIXIR_P2, 3 } },
        { xi.items.BOKWUS_BOOTS,            { xi.items.AIRLIXIR_P2, 3 } },
    },

    -- Kupon A-Sal: Salvage II (MOG_KUPON_A_SAL = 3969)
    [15] =
    {
        xi.items.ARES_MASK_P1,
        xi.items.ARES_CUIRASS_P1,
        xi.items.ARES_GAUNTLETS_P1,
        xi.items.ARES_FLANCHARD_P1,
        xi.items.ARES_SOLLERETS_P1,
        xi.items.SKADIS_VISOR_P1,
        xi.items.SKADIS_CUIRIE_P1,
        xi.items.SKADIS_BAZUBANDS_P1,
        xi.items.SKADIS_CHAUSSES_P1,
        xi.items.SKADIS_JAMBEAUX_P1,
        xi.items.USUKANE_SOMEN_P1,
        xi.items.USUKANE_HARAMAKI_P1,
        xi.items.USUKANE_GOTE_P1,
        xi.items.USUKANE_HIZAYOROI_P1,
        xi.items.USUKANE_SUNE_ATE_P1,
        xi.items.MARDUKS_TIARA_P1,
        xi.items.MARDUKS_JUBBAH_P1,
        xi.items.MARDUKS_DASTANAS_P1,
        xi.items.MARDUKS_SHALWAR_P1,
        xi.items.MARDUKS_CRACKOWS_P1,
        xi.items.MORRIGANS_CORONAL_P1,
        xi.items.MORRIGANS_ROBE_P1,
        xi.items.MORRIGANS_CUFFS_P1,
        xi.items.MORRIGANS_SLOPS_P1,
        xi.items.MORRIGANS_PIGACHES_P1,
    },

    -- Kupon A-Nyz: Nyzul Isle Uncharted Area Survey (MOG_KUPON_A_NYZ = 3970)
    [16] =
    {
        xi.items.PHORCYS_SALADE,
        xi.items.PHORCYS_KORAZIN,
        xi.items.PHORCYS_MITTS,
        xi.items.PHORCYS_DIRS,
        xi.items.PHORCYS_SCHUHS,
        xi.items.THAUMAS_HAT,
        xi.items.THAUMAS_COAT,
        xi.items.THAUMAS_GLOVES,
        xi.items.THAUMAS_KECKS,
        xi.items.THAUMAS_NAILS,
        xi.items.NARES_CAP,
        xi.items.NARES_SAIO,
        xi.items.NARES_CUFFS,
        xi.items.NARES_TREWS,
        xi.items.NARES_CLOGS,
    },
    -- Kupon I-S5: Skirmish Rank V Simulacrum Segments (MOG_KUPON_I_S5 = 3971)
    [17] =
    {
        xi.items.RALA_VISAGE_V,
        xi.items.CIRDAS_VISAGE_V,
        xi.items.FAITHFULS_TORSO_V,
        xi.items.PAIR_OF_FAITHFULS_LEGS_V,
        xi.items.YORCIA_VISAGE_V,
        xi.items.RAKAZNAR_VISGE_V,
    },

    -- Kupon I-S2: Skirmish Rank II Simulacrum Segments (MOG_KUPON_I_S2 = 3972)
    [18] =
    {
        xi.items.RALA_VISAGE_II,
        xi.items.CIRDAS_VISAGE_II,
        xi.items.FAITHFULS_TORSO_II,
        xi.items.PAIR_OF_FAITHFULS_LEGS_II,
        xi.items.YORCIA_VISAGE_II,
        xi.items.RAKAZNAR_VISGE_II,
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
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_1,  12 },
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_2,  12 },
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_3,  12 },
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_4,  12 },
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_5,  12 },
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_6,  12 },
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_7,  12 },
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_8,  12 },
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_9,  12 },
            { xi.items.COPY_OF_REMS_TALE_CHAPTER_10, 12 },
        },
    },

    -- Kupon W-EWS: Walk of Echoes Weapons (MOG_KUPON_W_EWS = 8730)
    [21] =
    {
        xi.items.DUMUZIS,
        xi.items.KHANDORMA,
        xi.items.BRUNELLO,
        xi.items.XIPHIAS,
        xi.items.SACRIPANTE,
        xi.items.SHAMASH,
        xi.items.UMILIATI,
        xi.items.DABOYA,
        xi.items.KASASAGI,
        xi.items.TORIGASHIRANOTACHI,
        xi.items.ROSE_COUVERTE,
        xi.items.PAIKEA,
        xi.items.CIRCINAE,
        xi.items.MOLLFRITH,
    },
    -- Kupon AW-WK: Weapon or Armor from Wildskeeper Reives (MOG_KUPON_AW_WKR = 8731)
    [22] =
    {
        -- Colkhab
        {
            { xi.items.PHAWAYLLA_EARRING    },
            { xi.items.IK_CAPE              },
            { xi.items.HUANI_COLLAR         },
            { xi.items.KUKU_STONE           },
            { xi.items.HATXIIK              },
            { xi.items.KUAKUAKAIT           },
            { xi.items.KAABNAX_HAT          },
            { xi.items.KAABNAX_TROUSERS     },
            { xi.items.TAIKOGANE            },
        },
        -- Tchakka
        {
            { xi.items.ATZINTLI_NECKLACE    },
            { xi.items.TUILHA_CAPE          },
            { xi.items.KALBORON_STONE       },
            { xi.items.CHOJ_BAND            },
            { xi.items.ATOYAC               },
            { xi.items.AZUKINAGAMITSU       },
            { xi.items.ATETEPEYORG          },
            { xi.items.EJEKAMAL_MASK        },
            { xi.items.EJEKAMAL_BOOTS       },
        },
        -- Achuka
        {
            { xi.items.CUAMIZ_COLLAR        },
            { xi.items.BUQUWIK_CAPE         },
            { xi.items.AQREQAQ_BOMBLET      },
            { xi.items.ACHAQ_GRIP           },
            { xi.items.MAOCHINOLI           },
            { xi.items.XIUTLEATO            },
            { xi.items.OTOMI_HELM           },
            { xi.items.OTOMI_GLOVES         },
        },
        -- Hurkan
        {
            { xi.items.HUNAHPU              },
            { xi.items.XBALANQUE            },
            { xi.items.TZACAB_GRIP          },
            { xi.items.ANIMIKII_BULLET      },
            { xi.items.KAQULJAAN            },
            { xi.items.UKUXKAJ_CAP          },
            { xi.items.UKUXKAJ_BOOTS        },
            { xi.items.JUKUKIK_FEATHER      },
            { xi.items.KAYAPA_CAPE          },
            { xi.items.PAQICHIKAJI_RING     },
            { xi.items.JAQIJ_SASH           },
        },
        -- Yumcax
        {
            { xi.items.IXTAB                },
            { xi.items.TAMAXCHI             },
            { xi.items.BUREMTE_HAT          },
            { xi.items.BUREMTE_GLOVES       },
            { xi.items.PAHTLI_CAPE          },
            { xi.items.OCACHI_GORGET        },
            { xi.items.KUNAJI_RING          },
            { xi.items.IXIMULEW_CAPE        },
            { xi.items.CHUQABA_BELT         },
            { xi.items.QUANPUR_NECKLACE     },
            { xi.items.BARATARIA_RING       },
        },
        -- Kumhau
        {
            { xi.items.TORO_CAPE            },
            { xi.items.FRIOMISI_EARRING     },
            { xi.items.TLAMIZTLI_COLLAR     },
            { xi.items.CETL_BELT            },
            { xi.items.AJJUB_BOW            },
            { xi.items.BAQIL_STAFF          },
            { xi.items.QUIAHUIZ_HELM        },
            { xi.items.QUIAHUIZ_TROUSERS    },
            { xi.items.NEPOTE_BELL          },
        },
    },

    -- Kupon I-S3: Skirmish Rank III Simulacrum Segments (MOG_KUPON_I_S3 = 8732)
    [23] =
    {
        xi.items.RALA_VISAGE_III,
        xi.items.CIRDAS_VISAGE_III,
        xi.items.FAITHFULS_TORSO_III,
        xi.items.PAIR_OF_FAITHFULS_LEGS_III,
        xi.items.YORCIA_VISAGE_III,
        xi.items.RAKAZNAR_VISGE_III,
    },

    -- Kupon A-PK109: iLevel 109 Peacekeeper Coalition Armor (MOG_KUPON_A_PK109 = 8733)
    [24] =
    {
        xi.items.KARIEYH_MORION_P1,
        xi.items.KARIEYH_HAUBERT_P1,
        xi.items.KARIEYH_MOUFLES_P1,
        xi.items.KARIEYH_BRAYETTES_P1,
        xi.items.KARIEYH_SOLLERETS_P1,
        xi.items.THURANDAUT_CHAPEAU_P1,
        xi.items.THURANDAUT_TABARD_P1,
        xi.items.THURANDAUT_GLOVES_P1,
        xi.items.THURANDAUT_TIGHTS_P1,
        xi.items.THURANDAUT_BOOTS_P1,
        xi.items.ORVAIL_CORONA_P1,
        xi.items.ORVAIL_ROBE_P1,
        xi.items.ORVAIL_CUFFS_P1,
        xi.items.ORVAIL_PANTS_P1,
        xi.items.ORVAIL_SOULIERS_P1,
    },

    -- Kupon I-S1: Skirmish Rank I Simulacrum Segments (MOG_KUPON_I_S1 = 8734)
    [25] =
    {
        xi.items.RALA_VISAGE_I,
        xi.items.CIRDAS_VISAGE_I,
        xi.items.FAITHFULS_TORSO_I,
        xi.items.PAIR_OF_FAITHFULS_LEGS_I,
        xi.items.YORCIA_VISAGE_I,
        xi.items.RAKAZNAR_VISGE_I,
    },

    -- Kupon I-Skill: Skill books (MOG_KUPON_I_SKILL = 8735)
    [26] =
    {
        -- Combat
        {
            xi.items.COPY_OF_MIKHES_MEMO,
            xi.items.DAGGER_ENCHIRIDION,
            xi.items.COPY_OF_SWING_AND_STAB,
            xi.items.COPY_OF_MIEUSELOIRS_DIARY,
            xi.items.COPY_OF_STRIKING_BULLS_DIARY,
            xi.items.COPY_OF_DEATH_FOR_DIMWITS,
            xi.items.COPY_OF_LUDWIGS_REPORT,
            xi.items.COPY_OF_CLASH_OF_TITANS,
            xi.items.COPY_OF_KAGETORAS_DIARY,
            xi.items.COPY_OF_NOILLURIES_LOG,
            xi.items.COPY_OF_FERREOUSS_DIARY,
            xi.items.COPY_OF_KAYEEL_PAYEELS_MEMOIRS,
            xi.items.COPY_OF_PERIHS_PRIMER,
            xi.items.COPY_OF_BARRELS_OF_FUN,
            xi.items.THROWING_WEAPON_ENCHIRIDION,
            xi.items.COPY_OF_MIKHES_NOTE,
            xi.items.COPY_OF_SONIAS_DIARY,
            xi.items.COPY_OF_THE_SUCCESSOR,
            xi.items.COPY_OF_KATETORAS_JOURNAL,
        },
        -- Magic
        {
            xi.items.COPY_OF_ALTANAS_HYMN,
            xi.items.COPY_OF_COVEFFE_BARROWS_MUSINGS,
            xi.items.COPY_OF_AID_FOR_ALL,
            xi.items.INVESTIGATIVE_REPORT,
            xi.items.BOUNTY_LIST,
            xi.items.COPY_OF_DARK_DEEDS,
            xi.items.COPY_OF_BREEZY_LIBRETTO,
            xi.items.CAVERNOUS_SCORE,
            xi.items.BEAMING_SCORE,
            xi.items.COPY_OF_YOMIS_DIAGRAM,
            xi.items.COPY_OF_ASTRAL_HOMELAND,
            xi.items.COPY_OF_LIFE_FORM_STUDY,
            xi.items.COPY_OF_HROHJS_RECORD,
            xi.items.COPY_OF_THE_BELL_TOLLS,
        },
    },
    --[[
    -- Kupon I-RME: RME Upgrade Materials x300
    [27] =
    {

    },

    -- 28: blank menu

    -- Kupon W-Job: JSE Oboro Weapons
    [29] =
    {

    },

    -- Kupon I-Mat: One type of special material (deprecated)
    [30] =
    {

    },

    -- Kupon W-DeIII: Delve boss weapons
    [31] =
    {

    },

    -- Kupon AW-Mis: Equipment or a weapon from High-Tier Mission Battlefields
    [32] =
    {

    },

    -- Kupon AW-Vgr: Equipment from Vagary Notorious Monsters Perfiden and Plouton
    [33] =
    {

    },

    -- Kupon AW-VgrII: Equipment from Vagary NMs Palloritus, Putraxia and Rancibus
    [34] =
    {

    },

    -- Mog Kupon W-Pulse: Pulse weapons
    [35] =
    {
        xi.items.GIRRU,
    },

    -- Kupon AW-GFII: Geas Fete (Content Level 119+) (deprecated)
    [37] =
    {

    },

    -- Kupon I-Stone: Augment stones (deprecated)
    [38] =
    {

    },

    -- Kupon AW-GF: Geas Fete (Content Level 119) (deprecated)
    [39] =
    {

    },

    -- Kupon AW-UWII: Level 119-128 Unity Wanted Battles
    [40] =
    {

    },

    -- Kupon AW-UW: Level 119 Unity Wanted Battles
    [41] =
    {

    },

    -- Kupon A-Ab: iLevel 119 +1 Abjuration Armor pieces
    [43] =
    {

    },

    -- Kupon AW-Cos: Various Costumes
    [44] =
    {

    },

    -- Kupon AW-Kupo: All four Kupo items
    [45] =
    {
        {
            -- TODO: Move to items.lua
            21074, -- Kupo Rod
            25645, -- Kupo Masque
            25726, -- Kupo Suit
            26406, -- Kupo Shield
        },
    },

    -- Kupon W-EMI: iLevel 117 Sparks of Eminence Weapons
    [46] =
    {

    },

    -- Kupon A-EMI: iLevel 117 Records of Eminence armor
    [47] =
    {

    },

    -- Kupon W-SRW: Rala Waterways Skirmish Weapons +2
    [48] =
    {

    },

    -- Kupon W-SCC: Cirdas Caverns Skirmish Weapons +2
    [49] =
    {

    },

    -- Kupon A-SYW: Yorcia Weald Skirmish Armor +1
    [50] =
    {

    },

    -- Kupon W-ASRW: Rala Waterways Alluvion Skirmish Weapons
    [51] =
    {

    },

    -- Kupon W-ASCC: Cirdas Caverns Alluvion Skirmish Weapons
    [52] =
    {

    },

    -- Kupon A-ASYW: Yorcia Weald Alluvion Skirmish Armor
    [53] =
    {

    },

    -- Kupon W-R119: iLevel 119 III Relic Weapons (deprecated)
    [54] =
    {

    },

    -- Kupon W-M119: iLevel 119 III Mythic Weapons and Ergon Weapons (deprecated)
    [55] =
    {

    },

    -- Kupon W-E119: iLevel 119 III Empyrean Weapons (deprecated)
    [56] =
    {

    },

    -- Kupon W-A119: Aeonic Weapons (deprecated)
    [57] =
    {

    },

    -- Kupon A-OmII: Body pieces from Omen bosses
    [59] =
    {

    },

    -- Kupon I-AF119: Scale needed for the Reforged Artifact Armor +3 process
    [60] =
    {

    },

    -- Kupon AW-Om: Equipment pieces from Omen mid-bosses
    [61] =
    {

    },

    -- Kupon W-RMEA: iLevel 119 III Relic, Mythic, Empyrean or Aeonic Weapon
    [62] =
    {

    },
    ]]
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

xi.dealerMoogle.onEventUpdate = function(player, csid, option)
    -- print("update", csid, option)
end

xi.dealerMoogle.onEventFinish = function(player, csid, option)
    -- print("finish", csid, option)
    if option == 0 then
        return
    end

    local zoneID = player:getZoneID()
    local itemCsid = csidLookup[zoneID][2]

    if csid == itemCsid then
        local list      = bit.band(option, 0xFF)
        local idx       = bit.rshift(option, 8)
        local idxAlt1   = 0
        local idxAlt2   = 0

        if list == 12 then -- I-Seal submenu format
            idxAlt1 = bit.band(bit.rshift(option, 16), 0xFF) -- Job
            idxAlt2 = bit.band(bit.rshift(option, 8), 0x3F) -- Slot
        end

        if list == 22 then -- AW-WK submenu format
            idxAlt1 = bit.rshift(option, 24) -- Naakul
            idxAlt2 = bit.band(bit.rshift(option, 8), 0xF) -- Item
        end

        if list == 26 then -- I-Skill submenu format
            idxAlt1 = bit.rshift(option, 24) -- Combat / Magic
            idxAlt2 = bit.band(bit.rshift(option, 8), 0x3F) -- Item
        end

        -- DEBUG:
        -- print(string.format("list: %u, idx: %u", list, idx))
        -- print(string.format("list: %u, idx: %u, job %u, slot: %u", list, idx, idxAlt1, idxAlt2))

        if list > 0 and idx == 0 then
            player:addKeyItem(listToKeyItem(list))
        elseif list > 0 and idx > 0 then
            local item      = 0
            local keyItems  = 0

            if list == 12 then
                item = { itemList[list][idxAlt1][idxAlt2] } -- Tabling here to save 100 pairs of { }
            elseif list == 22 or list == 26 then
                item = itemList[list][idxAlt1][idxAlt2]
            else
                item = itemList[list][idx]
            end

            if list == 19 then -- List 19 has keyitems
                keyItems = 1
            end

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
