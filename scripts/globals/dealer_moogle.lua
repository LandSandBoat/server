-----------------------------------
-- Dealer Moogles & Kupon Global
-- https://www.bg-wiki.com/ffxi/Category:Mog_Bonanza
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.dealerMoogle = xi.dealerMoogle or {}

local debug =
{
    ENABLED     = false,    -- will disable ki consumption and print instead
    SHOWITEM    = true,     -- will display acquisition message to player if debug.ENABLED
    TO_PLAYER   = true,     -- will print debug info to player if debug.ENABLED
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
        { xi.items.TWASHTAR_90,     xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTDROSS,  60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.ALMACE_90,       xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.CALADBOLG_90,    xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTDROSS,  60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.FARSHA_90,       xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.UKONVASARA_90,   xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTDROSS,  60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.REDEMPTION_90,   xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.RHONGOMIANT_90,  xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.KANNAGI_90,      xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTDROSS,  60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.MASAMUNE_90,     xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.GAMBANTEINN_90,  xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTDROSS,  60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.HVERGELMIR_90,   xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTDROSS,  60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.GANDIVA_90,      xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.ARMAGEDDON_90,   xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTDROSS,  60 }, { xi.items.RIFTBORN_BOULDER, 300 } },
        { xi.items.DAURDABLA_90,    xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTCINDER, 60 },                                    },
        { xi.items.OCHAIN_90,       xi.items.DENSE_CLUSTER, { xi.items.PINCH_OF_RIFTDROSS,  60 },                                    },
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
    -- Kupon AW-WK: Weapon or Armor from Wildskeeper Reives (MOG_KUPON_AW_WK = 8731)
    [22] =
    {
        -- Colkhab
        {
            xi.items.PHAWAYLLA_EARRING,
            xi.items.IK_CAPE,
            xi.items.HUANI_COLLAR,
            xi.items.KUKU_STONE,
            xi.items.HATXIIK,
            xi.items.KUAKUAKAIT,
            xi.items.KAABNAX_HAT,
            xi.items.KAABNAX_TROUSERS,
            xi.items.TAIKOGANE,
        },
        -- Tchakka
        {
            xi.items.ATZINTLI_NECKLACE,
            xi.items.TUILHA_CAPE,
            xi.items.KALBORON_STONE,
            xi.items.CHOJ_BAND,
            xi.items.ATOYAC,
            xi.items.AZUKINAGAMITSU,
            xi.items.ATETEPEYORG,
            xi.items.EJEKAMAL_MASK,
            xi.items.EJEKAMAL_BOOTS,
        },
        -- Achuka
        {
            xi.items.CUAMIZ_COLLAR,
            xi.items.BUQUWIK_CAPE,
            xi.items.AQREQAQ_BOMBLET,
            xi.items.ACHAQ_GRIP,
            xi.items.MAOCHINOLI,
            xi.items.XIUTLEATO,
            xi.items.OTOMI_HELM,
            xi.items.OTOMI_GLOVES,
        },
        -- Hurkan
        {
            xi.items.HUNAHPU,
            xi.items.XBALANQUE,
            xi.items.TZACAB_GRIP,
            xi.items.ANIMIKII_BULLET,
            xi.items.KAQULJAAN,
            xi.items.UKUXKAJ_CAP,
            xi.items.UKUXKAJ_BOOTS,
            xi.items.JUKUKIK_FEATHER,
            xi.items.KAYAPA_CAPE,
            xi.items.PAQICHIKAJI_RING,
            xi.items.JAQIJ_SASH,
        },
        -- Yumcax
        {
            xi.items.IXTAB,
            xi.items.TAMAXCHI,
            xi.items.BUREMTE_HAT,
            xi.items.BUREMTE_GLOVES,
            xi.items.PAHTLI_CAPE,
            xi.items.OCACHI_GORGET,
            xi.items.KUNAJI_RING,
            xi.items.IXIMULEW_CAPE,
            xi.items.CHUQABA_BELT,
            xi.items.QUANPUR_NECKLACE,
            xi.items.BARATARIA_RING,
        },
        -- Kumhau
        {
            xi.items.TORO_CAPE,
            xi.items.FRIOMISI_EARRING,
            xi.items.TLAMIZTLI_COLLAR,
            xi.items.CETL_BELT,
            xi.items.AJJUB_BOW,
            xi.items.BAQIL_STAFF,
            xi.items.QUIAHUIZ_HELM,
            xi.items.QUIAHUIZ_TROUSERS,
            xi.items.NEPOTE_BELL,
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

    -- Kupon I-RME: RME Upgrade Materials x300 (MOG_KUPON_I_RME = 8738)
    [27] =
    {
        { { xi.items.PLUTON,            300 } },
        { { xi.items.BEITETSU,          300 } },
        { { xi.items.RIFTBORN_BOULDER,  300 } },
    },

    -- 28: blank menu

    -- Kupon W-Job: JSE Oboro Weapons (MOG_KUPON_W_JOB = 8793)
    [29] =
    {
        xi.items.MINOS,
        xi.items.NYEPEL,
        xi.items.SINDRI,
        xi.items.KALADANDA,
        xi.items.EGEKING,
        xi.items.SANDUNG,
        xi.items.PRIWEN,
        xi.items.CRONUS,
        xi.items.ARKTOI,
        xi.items.TERPANDER,
        xi.items.LIONSQUALL,
        xi.items.KURIKARANOTACHI,
        xi.items.SHIGI,
        xi.items.AREADBHAR,
        xi.items.GRIDARVOR,
        xi.items.MIMESIS,
        xi.items.DEATHLOCKE,
        xi.items.OHTAS,
        xi.items.POLYHYMNIA,
        xi.items.COEUS,
        xi.items.DUNNA,
        xi.items.AETTIR,
    },
    -- Kupon I-Mat: One type of special material (MOG_KUPON_I_MAT = 8794)
    [30] =
    {
        xi.items.BZTAVIAN_STINGER,
        xi.items.BZTAVIAN_WING,
        xi.items.ROCKFIN_TOOTH,
        xi.items.ROCKFIN_FIN,
        xi.items.GABBRATH_HORN,
        xi.items.SLICE_OF_GABBRATH_MEAT,
        xi.items.WAKTZA_ROSTRUM,
        xi.items.WAKTZA_CREST,
        xi.items.YGGDREANT_BOLE,
        xi.items.YGGDREANT_ROOT,
        xi.items.CEHUETZI_CLAW,
        xi.items.CEHUETZI_PELT,
        xi.items.CEHUETZI_ICE_SHARD,
        xi.items.SCARLETITE_INGOT,
        xi.items.ORMOLU_INGOT,
        xi.items.VOIDWROUGHT_PLATE,
        xi.items.KAGGENS_CUTICLE,
        xi.items.AKVANS_PENNON,
        xi.items.SUIT_OF_HAHAVAS_MAIL,
        xi.items.PILS_TUILLIE,
        xi.items.CELAENOS_CLOTH,
    },

    -- Kupon W-DeIII: Delve boss weapons (MOG_KUPON_DEIII = 8795)
    [31] =
    {
        xi.items.OATIXUR,
        xi.items.KEREHCATL,
        xi.items.UPUKIREX,
        xi.items.IZHIIKOH,
        xi.items.TSURUMARU,
        xi.items.ILLAPA,
        xi.items.BURAMENKAH,
        xi.items.UKUDYONI,
        xi.items.IZIZOEKSI,
        xi.items.TAJABIT,
        xi.items.QALGWER,
        xi.items.BOLELABUNGA,
        xi.items.NGQOQWANB,
        xi.items.FALUBEZA,
        xi.items.JUSHIMATSU,
    },

    -- Kupon AW-Mis: Equipment or a weapon from High-Tier Mission Battlefields (MOG_KUPON_AW_MIS = 8796)
    [32] =
    {
            -- Ark Angel 1
        {
            xi.items.LITHELIMB_CAP,
            xi.items.BLOODRAIN_STRAP,
            xi.items.ANAHERA_SABER,
            xi.items.CASTIGATION,
            xi.items.MANABYSS_PIGACHES,
        },
            -- Ark Angel 2
        {
            xi.items.ANAHERA_SCYTHE,
            xi.items.FRAVASHI_MANTLE,
            xi.items.VENABULUM,
            xi.items.SCAMPS_SOLLERETS,
            xi.items.THEURGISTS_SLACKS,
        },
            -- Ark Angel 3
        {
            xi.items.SEKHMET_CORSET,
            xi.items.REGIMEN_MITTENS,
            xi.items.FELISTRIS_MASK,
            xi.items.RAIMITSUKANE,
            xi.items.ANAHERA_TABAR,
        },
            -- Ark Angel 4
        {
            xi.items.CAGLIOSTROS_ROD,
            xi.items.ANAHERA_SWORD,
            xi.items.PATRICIUS_RING,
            xi.items.DYNASTY_MITTS,
            xi.items.OSMIUM_CUISSES,
        },
            -- Ark Angel 5
        {
            xi.items.AGITATORS_COLLAR,
            xi.items.DAIHANSHI_HABAKI,
            xi.items.TUNGLMYRKVI,
            xi.items.LURID_MITTS,
            xi.items.ANAHERA_BLADE,
        },
            -- Pentacide Perpetrator
        {
            xi.items.KYUJUTSUGI,
            xi.items.LENTUS_GRIP,
            xi.items.NONE, -- Gap slot 3
            xi.items.NONE, -- Gap slot 4
            xi.items.TRUX_EARRING,
            xi.items.SANARE_EARRING,
            xi.items.GELAI_EARRING,
            xi.items.CREMATIO_EARRING,
            xi.items.TRIPUDIO_EARRING,
        },
            -- Return to Delkfutt's Tower
        {
            xi.items.MESYOHI_HAUBERGEON,
            xi.items.MESYOHI_SLACKS,
            xi.items.MESYOHI_SWORD,
            xi.items.MESYOHI_ROD,
        },
            -- The Celestial Nexus
        {
            xi.items.VANIR_GUN,
            xi.items.VANIR_KNIFE,
            xi.items.VANIR_COTEHARDIE,
            xi.items.VANIR_BATTERY,
            xi.items.VANIR_BOOTS,
        },
            -- The Savage
        {
            xi.items.ISCHEMIA_CHASUBLE,
            xi.items.SCUFFLERS_COSCIALES,
            xi.items.HEGIRA_WRISTBANDS,
            xi.items.METALSINGER_BELT,
            xi.items.DOMESTICATORS_EARRING,
        },
            -- The Warriors Path
        {
            xi.items.HANGAKU_NO_YUMI,
            xi.items.SUKEROKU_HACHIMAKI,
            xi.items.BATTLECAST_GAITERS,
            xi.items.GINSEN,
            xi.items.MIZUKAGE_NO_KUBIKAZARI,
        },
            -- Puppet In Peril
        {
            xi.items.SAVAS_JAWSHAN,
            xi.items.SIFAHIR_SLACKS,
            xi.items.SAHIP_HELM,
            xi.items.BESTAS_BANE,
            xi.items.PRATIK_EARRING,
        },
            -- Legacy of the Lost
        {
            xi.items.PTICA_HEADGEAR,
            xi.items.KARMESIN_VEST,
            xi.items.KANDZA_CRACKOWS,
            xi.items.TENGU_NO_HANE,
            xi.items.TENGU_NO_OBI,
        },
            -- Rank Five Missions
        {
            xi.items.LIGHTREAVER,
            xi.items.DREAD_JUPON,
            xi.items.ONIMUSHA_NO_KOTE,
            xi.items.PERDITION_SLOPS,
            xi.items.TREPIDITY_MANTLE,
        },
            -- Head Wind
        {
            xi.items.DURGAI_LEGGINGS,
            xi.items.CHIDORI,
            xi.items.BAGHERE_SALADE,
            xi.items.SHETAL_STONE,
            xi.items.NILGAL_POLE,
        },
            -- Trial By Fire
        {
            xi.items.ATAKIGIRI,
            xi.items.COALRAKE_SABOTS,
            xi.items.PERFERVID_SWORD,
            xi.items.IMMOLATION_GRIP,
            xi.items.ANNEALED_MANTLE,
        },
            -- Trial By Ice
        {
            xi.items.FRAZIL_STAFF,
            xi.items.FLOESTONE,
            xi.items.CALVED_CLAWS,
            xi.items.NILAS_GLOVES,
            xi.items.RIMEICE_EARRING,
        },
            -- Trial By Wind
        {
            xi.items.LEVANTE_DAGGER,
            xi.items.PONENTE_SASH,
            xi.items.LEBECHE_RING,
            xi.items.TRAMONTANE_AXE,
            xi.items.OSTRO_GREAVES,
        },
            -- Trial By Earth
        {
            xi.items.MAFIC_CUDGEL,
            xi.items.SUPERSHEAR_RING,
            xi.items.TOGAKUSHI_SHURIKEN_POUCH,
            xi.items.FORESHOCK_SWORD,
            xi.items.PLUMOSE_SACHET,
        },
            -- Trial By Lightning
        {
            xi.items.STACCATO_STAFF,
            xi.items.DONAR_GUN,
            xi.items.UKKO_SASH,
            xi.items.VOLTSURGE_TORQUE,
            xi.items.BRONTES_CUISSES,
        },
            -- Trial By Water
        {
            xi.items.PHREATIC_AXE,
            xi.items.PELAGOS_LANCE,
            xi.items.VADOSE_ROD,
            xi.items.BENTHOS_GRIP,
            xi.items.NERITIC_EARRING,
        },
            -- The Moonlit Path
        {
            xi.items.MEDEINA_KILIJ,
            xi.items.CAPITOLINE_STRAP,
            xi.items.MAIITSOH_HAUBE,
            xi.items.VRIKODARA_JUPON,
            xi.items.LUPINE_CAPE,
        },
            -- Waking the Beast
        {
            xi.items.MARQUETRY_STAFF,
            xi.items.LAPIDARY_TUNIC,
            xi.items.DIAMANTAIRE_SOLLERETS,
            xi.items.SATLADA_NECKLACE,
            xi.items.ENGRAVED_BELT,
        },
            -- Waking Dreams
        {
            xi.items.SHUHANSADAMUNE,
            xi.items.CHOZORON_COSELETE,
            xi.items.LOAGAETH_CUFFS,
            xi.items.DARKSIDE_EARRING,
            xi.items.PERNICIOUS_RING,
        },
            -- One to Be Feared
        {
            xi.items.DENOUEMENTS,
            xi.items.TERMINAL_HELM,
            xi.items.TERMINAL_PLATE,
            xi.items.CONSUMMATION_TORQUE,
            xi.items.CULMINUS,
            xi.items.CESSANCE_EARRING,
        },
            -- Dawn
        {
            xi.items.GYVE_DOUBLET,
            xi.items.FETTERING_BLADE,
            xi.items.VENERY_BOW,
            xi.items.LATRIA_SASH,
            xi.items.GYVE_TROUSERS,
            xi.items.LAIC_MANTLE,
        },
            -- Other
        {
            xi.items.DIVINATOR,
            xi.items.DIVINATOR_II,
            xi.items.SERAPHICALLER,
        },
    },

    -- Kupon AW-Vgr: Equipment from Vagary Notorious Monsters Perfiden and Plouton (MOG_KUPON_AW_VGR = 9087)
    [33] =
    {
            -- Perfidien
        {
            xi.items.COUNTS_GARB,
            xi.items.COUNTS_CUFFS,
            xi.items.ETIOLATION_EARRING,
            xi.items.ENERVATING_EARRING,
        },
            -- Plouton
        {
            xi.items.TARTARUS_PLATEMAIL,
            xi.items.BEFOULED_CROWN,
            xi.items.ODIUM,
            xi.items.INCARNATION_SASH,
        }
    },

    -- Kupon AW-VgrII: Equipment from Vagary NMs Palloritus, Putraxia and Rancibus (MOG_KUPON_AW_VGRII = 9088)
    [34] =
    {
            -- Palloritus
        {
            xi.items.ACHIUCHIKAPU,
            xi.items.RHADAMANTHUS,
            xi.items.PUNCHINELLOS,
            xi.items.DEFIANT_COLLAR,
        },
            -- Putraxia
        {
            xi.items.SOULCLEAVER,
            xi.items.ACCLIMATOR,
            xi.items.CRUSHERS_GAUNTLETS,
            xi.items.RUMINATION_SASH,
        },
            -- Rancibus
        {
            xi.items.MIASMIC_PANTS,
            xi.items.CRYPTIC_EARRING,
            xi.items.MINDMELTER,
            xi.items.DEVIVIFIER,
        },
    },
    -- Mog Kupon W-Pulse: Pulse weapons (MOG_KUPON_W_PULSE = 9089)
    [35] =
    {
        xi.items.GIRRU,
        xi.items.CORUSCANTI,
        xi.items.ASTERIA,
        xi.items.GUSTERION,
        xi.items.SAGASINGER,
        xi.items.EPHEMERON,
        xi.items.BOREALIS,
        xi.items.AYTANRI,
        xi.items.HIMTHIGE,
        xi.items.DELPHINIUS,
        xi.items.ADFLICTIO,
        xi.items.IKARIGIRI,
        xi.items.MURASAMEMARU,
        xi.items.TENKOMARU,
        xi.items.DUKKHA,
    },

    -- Kupon I-Stone: Skirmish Stones +2 (MOG_KUPON_I_STONE = 9090)
    [36] =
    {
        { { xi.items.VERDIGRIS_STONE_P2,          12 } },
        { { xi.items.GHASTLY_STONE_P2,            12 } },
        { { xi.items.WAILING_STONE_P2,            12 } },
        { { xi.items.SNOWSLIT_STONE_P2,           12 } },
        { { xi.items.SNOWTIP_STONE_P2,            12 } },
        { { xi.items.SNOWDIM_STONE_P2,            12 } },
        { { xi.items.SNOWORB_STONE_P2,            12 } },
        { { xi.items.LEAFSLIT_STONE_P2,           12 } },
        { { xi.items.LEAFTIP_STONE_P2,            12 } },
        { { xi.items.LEAFDIM_STONE_P2,            12 } },
        { { xi.items.LEAFORB_STONE_P2,            12 } },
        { { xi.items.DUSKSLIT_STONE_P2,           12 } },
        { { xi.items.DUSKTIP_STONE_P2,            12 } },
        { { xi.items.DUSKDIM_STONE_P2,            12 } },
        { { xi.items.DUSKORB_STONE_P2,            12 } },
        { { xi.items.FRAYED_SACK_OF_FECUNDITY,    12 } },
        { { xi.items.FRAYED_SACK_OF_PLENTY,       12 } },
        { { xi.items.FRAYED_SACK_OF_OPULENCE,     12 } },
    },
    -- Kupon AW-GFIII: Geas Fete (Content Level 119+) (MOG_KUPON_AW_GFIII = 9175)
    [37] =
    {
            -- HAND-TO-HAND WEAPONS
        {
            xi.items.NIBIRU_SAINTI,
            xi.items.CHASTISERS,
            xi.items.HAMMERFISTS,
            xi.items.MIDNIGHTS,
            xi.items.ESHUS,
            xi.items.CONDEMNERS,
        },
            -- DAGGERS
        {
            xi.items.NIBIRU_KNIFE,
            xi.items.ENCHUFLA,
            xi.items.SHIJO,
            xi.items.KALI,
            xi.items.SKINFLAYER,
            xi.items.SANGOMA,
        },
            -- SWORDS
        {
            xi.items.NIBIRU_BLADE,
            xi.items.NIXXER,
            xi.items.EMISSARY,
            xi.items.IRIS,
            xi.items.COLADA,
            xi.items.NONE, -- Gap slot 6
            xi.items.DEACON_SABER,
            xi.items.DEACON_SWORD,
            xi.items.KOBOTO,
            xi.items.REIKIKO,
        },
            -- GREAT SWORDS
        {
            xi.items.NIBIRU_FAUSSAR,
            xi.items.BIDENHANDER,
            xi.items.ZULFIQAR,
        },
            -- AXES
        {
            xi.items.NIBIRU_TABAR,
            xi.items.SKULLRENDER,
            xi.items.DIGIRBALAG,
            xi.items.NONE, -- Gap slot 4
            xi.items.DEACON_TABAR,
        },
            -- GREAT AXES
        {
            xi.items.NIBIRU_CHOPPER,
            xi.items.ROUTER,
            xi.items.INSTIGATOR,
            xi.items.AGANOSHE,
            xi.items.NONE, -- Gap slot 5
            xi.items.REIKIONO,
            xi.items.JOKUSHUONO,
        },
            -- POLEARMS
        {
            xi.items.NIBIRU_LANCE,
            xi.items.ANNEALED_LANCE,
            xi.items.RHOMPHAIA,
            xi.items.REIENKYO,
            xi.items.NONE, -- Gap slot 5
            xi.items.HABILE_MAZRAK,
        },
            -- SCYTHES
        {
            xi.items.NIBIRU_SICKLE,
            xi.items.DEATHBANE,
            xi.items.OBSCHINE,
            xi.items.MISANTHROPY,
            xi.items.DACNOMANIA,
            xi.items.DEACON_SCYTHE,
            xi.items.SHUKUYUS_SCYTHE,
        },
            -- KATANAS
        {
            xi.items.MIJIN,
            xi.items.AIZUSHINTOGO,
            xi.items.KANARIA,
        },
            -- GREAT KATANAS
        {
            xi.items.SENSUI,
            xi.items.ICHIGOHITOFURI,
            xi.items.UMARU,
            xi.items.NONE, -- Gap slot 4
            xi.items.DEACON_BLADE,
        },
            -- CLUBS
        {
            xi.items.NIBIRU_CUDGEL,
            xi.items.QUELLER_ROD,
            xi.items.SOLSTICE,
            xi.items.SUCELLUS,
            xi.items.GADA,
        },
            -- STAVES
        {
            xi.items.NIBIRU_STAFF,
            xi.items.ESPIRITUS,
            xi.items.AKADEMOS,
            xi.items.LATHI,
            xi.items.GRIOAVOLR,
            xi.items.NONE, -- Gap slot 6
            xi.items.NONE, -- Gap slot 7
            xi.items.REIKIKON,
        },
            -- THROWING WEAPONS
        {
            xi.items.SERAPHIC_AMPULLA,
            xi.items.GRENADE_CORE,
            xi.items.SAPIENCE_ORB,
            xi.items.FALCON_EYE,
            xi.items.ALBIN_BANE,
            xi.items.AMAR_CLUSTER,
            xi.items.HYDROCERA,
            xi.items.MANTOPTERA_EYE,
            xi.items.EXPEDITIOUS_PINION,
            xi.items.PEMPHREDO_TATHLUM,
            xi.items.ELIS_TOME,
        },
            -- BOWS
        {
            xi.items.NIBIRU_BOW,
            xi.items.VIJAYA_BOW,
            xi.items.TELLER,
        },
            -- GUNS
        {
            xi.items.NIBIRU_GUN,
            xi.items.COMPENSATOR,
            xi.items.NONE, -- Gap slot 3
            xi.items.HOLLIDAY,
            xi.items.MOLYBDOSIS,
        },
            -- SHIELDS
        {
            xi.items.NIBIRU_SHIELD,
            xi.items.GENMEI_SHIELD,
        },
            -- INSTRUMENTS
        {
            xi.items.NIBIRU_HARP,
        },
            -- GRIPS
        {
            xi.items.CLEMENCY_GRIP,
            xi.items.WILLPOWER_GRIP,
            xi.items.FOREFATHERS_GRIP,
            xi.items.GIUOCO_GRIP,
            xi.items.BALARAMA_GRIP,
            xi.items.NIOBID_STRAP,
            xi.items.POTENT_GRIP,
            xi.items.THRACE_STRAP,
            xi.items.ALBER_STRAP,
        },
            -- HEADGEAR
        {
            xi.items.ESCHITE_HELM,
            xi.items.PSYCLOTH_TIARA,
            xi.items.RAWHIDE_MASK,
            xi.items.DESPAIR_HELM,
            xi.items.VANYA_HOOD,
            xi.items.PURSUERS_BERET,
            xi.items.NAGA_SOMEN,
            xi.items.SKORMOTH_MASK,
            xi.items.ODYSSEAN_HELM,
            xi.items.VALOROUS_MASK,
            xi.items.HERCULEAN_HELM,
            xi.items.MERLINIC_HOOD,
            xi.items.CHIRONIC_HAT,
            xi.items.NONE, -- Gap slot 14
            xi.items.NONE, -- Gap slot 15
            xi.items.GENMEI_KABUTO,
        },
            -- CHEST ARMOR
        {
            xi.items.ESCHITE_BREASTPLATE,
            xi.items.PSYCLOTH_VEST,
            xi.items.RAWHIDE_VEST,
            xi.items.DESPAIR_MAIL,
            xi.items.VANYA_ROBE,
            xi.items.PURSUERS_DOUBLET,
            xi.items.NAGA_SAMUE,
            xi.items.SWELLERS_HARNESS,
            xi.items.ONCA_SUIT,
            xi.items.KUBIRA_MEIKOGAI,
            xi.items.ANNOINTED_KALASIRIS,
            xi.items.MAKORA_MEIKOGAI,
            xi.items.ENFORCERS_HARNESS,
            xi.items.UAC_JERKIN,
            xi.items.SHANGO_ROBE,
            xi.items.ABNOBA_KAFTAN,
            xi.items.ODYSSEAN_CHESTPLATE,
            xi.items.VALOROUS_MAIL,
            xi.items.HERCULEAN_VEST,
            xi.items.MERLINIC_JUBBAH,
            xi.items.CHIRONIC_DOUBLET,
            xi.items.NONE, -- Gap slot 22
            xi.items.NONE, -- Gap slot 23
            xi.items.NONE, -- Gap slot 24
            xi.items.ZENDIK_ROBE,
            xi.items.REIKI_OSODE,
        },
            -- GLOVES AND GAUNTLETS
        {
            xi.items.NAGA_TEKKO,
            xi.items.ESCHITE_GAUNTLETS,
            xi.items.PSYCLOTH_MANILLAS,
            xi.items.RAWHIDE_GLOVES,
            xi.items.DESPAIR_FINGER_GLOVES,
            xi.items.VANYA_CUFFS,
            xi.items.PURSUERS_CUFFS,
            xi.items.SHRIEKERS_CUFFS,
            xi.items.KURYS_GLOVES,
            xi.items.ODYSSEAN_GAUNTLETS,
            xi.items.VALOROUS_MITTS,
            xi.items.HERCULEAN_GLOVES,
            xi.items.MERLINIC_DASTANAS,
            xi.items.CHIRONIC_GLOVES,
            xi.items.COMPOSERS_MITTS,
            xi.items.NONE, -- Gap slot 16
            xi.items.NONE, -- Gap slot 17
            xi.items.KOBO_KOTE,
        },
            -- LEG ARMOR
        {
            xi.items.NAGA_HAKAMA,
            xi.items.ESCHITE_CUISSES,
            xi.items.PSYCLOTH_LAPPAS,
            xi.items.RAWHIDE_TROUSERS,
            xi.items.DESPAIR_CUISSES,
            xi.items.VANYA_SLOPS,
            xi.items.PURSUERS_PANTS,
            xi.items.DOYEN_PANTS,
            xi.items.OBATALA_SUBLIGAR,
            xi.items.SELVANS_SUBLIGAR,
            xi.items.ODYSSEAN_CUISSES,
            xi.items.VALOROUS_HOSE,
            xi.items.HERCULEAN_TROUSERS,
            xi.items.MERLINIC_SHALWAR,
            xi.items.CHIRONIC_HOSE,
            xi.items.NONE, -- Gap slot 16
            xi.items.JOKUSHU_HAIDATE,
        },
            -- BOOTS AND GREAVES
        {
            xi.items.PURSUERS_GAITERS,
            xi.items.NAGA_KYAHAN,
            xi.items.ESCHITE_GREAVES,
            xi.items.PSYCLOTH_BOOTS,
            xi.items.RAWHIDE_BOOTS,
            xi.items.DESPAIR_GREAVES,
            xi.items.VANYA_CLOGS,
            xi.items.INSPIRITED_BOOTS,
            xi.items.TUTYR_SABOTS,
            xi.items.ODYSSEAN_GREAVES,
            xi.items.VALOROUS_GREAVES,
            xi.items.HERCULEAN_BOOTS,
            xi.items.MERLINIC_CRACKOWS,
            xi.items.CHIRONIC_SLIPPERS,
            xi.items.COMPOSERS_SABOTS,
            xi.items.NONE, -- Gap slot 16
            xi.items.NONE, -- Gap slot 17
            xi.items.NONE, -- Gap slot 18
            xi.items.SHUKUYU_SUNE_ATE,
        },
            -- NECK PIECES
        {
            xi.items.MARKED_GORGET,
            xi.items.SUBTLETY_SPECTACLES,
            xi.items.DAMPENERS_TORQUE,
            xi.items.EMPATH_NECKLACE,
            xi.items.RETI_PENDANT,
            xi.items.DIEMER_GORGET,
            xi.items.CARO_NECKLACE,
            xi.items.NODENS_GORGET,
            xi.items.CLOTHARIUS_TORQUE,
            xi.items.DEINO_COLLAR,
            xi.items.HOMERIC_GORGET,
            xi.items.AINIA_COLLAR,
            xi.items.JOKUSHU_CHAIN,
        },
            -- EARRINGS
        {
            xi.items.MENDICANTS_EARRING,
            xi.items.INFUSED_EARRING,
            xi.items.CALAMITOUS_EARRING,
            xi.items.HERMETIC_EARRING,
            xi.items.HALASZ_EARRING,
            xi.items.ASSUAGE_EARRING,
            xi.items.ISHVARA_EARRING,
            xi.items.EVANS_EARRING,
            xi.items.LEMPO_EARRING,
            xi.items.THUREOUS_EARRING,
            xi.items.DIGNITARYS_EARRING,
            xi.items.TELOS_EARRING,
            xi.items.GENMEI_EARRING,
        },
            -- BELTS AND SASHES
        {
            xi.items.LUCIDITY_SASH,
            xi.items.SINEW_BELT,
            xi.items.ESCHAN_STONE,
            xi.items.GRUNFELD_ROPE,
            xi.items.POROUS_ROPE,
            xi.items.SULLA_BELT,
            xi.items.YEMAYA_BELT,
            xi.items.CHANNELERS_STONE,
            xi.items.ASKLEPIAN_BELT,
            xi.items.SARISSAPHOROI_BELT,
            xi.items.LUMINARY_SASH,
            xi.items.KERYGMA_BELT,
            xi.items.REIKI_YOTAI,
            xi.items.KOBO_OBI,
        },
            -- RINGS
        {
            xi.items.OVERBEARING_RING,
            xi.items.RESONANCE_RING,
            xi.items.PURITY_RING,
            xi.items.WARDENS_RING,
            xi.items.PETROV_RING,
            xi.items.FORTIFIED_RING,
            xi.items.VERTIGO_RING,
            xi.items.EVANESCENCE_RING,
            xi.items.BEGRUDGING_RING,
            xi.items.APATE_RING,
            xi.items.PERSIS_RING,
            xi.items.HETAIROI_RING,
            xi.items.SHUKUYU_RING,
            xi.items.RAHAB_RING,
        },
            -- CAPES AND CLOAKS
        {
            xi.items.DISPERSERS_CAPE,
            xi.items.THAUMATURGES_CAPE,
            xi.items.PENETRATING_CAPE,
            xi.items.PHILIDOR_MANTLE,
            xi.items.SOKOLSKI_MANTLE,
            xi.items.QUARREL_MANTLE,
            xi.items.XUCAU_MANTLE,
            xi.items.TANTALIC_CAPE,
            xi.items.SCINTILLATING_CAPE,
            xi.items.PHALANGITE_MANTLE,
            xi.items.PERIMEDE_CAPE,
            xi.items.AGEMA_CAPE,
            xi.items.ENUMA_MANTLE,
            xi.items.REIKI_CLOAK,
        },
            -- OTHER
        {
            xi.items.SEKI_SHURIKEN_POUCH,
        },
    },

    -- Kupon AW-GFII: Geas Fete (MOG_KUPN_AW_GWII = 9176)
    [38] =
    {
            -- HAND-TO-HAND WEAPONS
        {
            xi.items.NIBIRU_SAINTI,
            xi.items.CHASTISERS,
            xi.items.HAMMERFISTS,
            xi.items.MIDNIGHTS,
            xi.items.ESHUS,
            xi.items.CONDEMNERS,
        },
            -- DAGGERS
        {
            xi.items.NIBIRU_KNIFE,
            xi.items.ENCHUFLA,
            xi.items.SHIJO,
            xi.items.KALI,
            xi.items.SKINFLAYER,
        },
            -- SWORDS
        {
            xi.items.NIBIRU_BLADE,
            xi.items.NIXXER,
            xi.items.EMISSARY,
            xi.items.IRIS,
            xi.items.COLADA,
        },
            -- GREAT SWORDS
        {
            xi.items.NIBIRU_FAUSSAR,
            xi.items.BIDENHANDER,
            xi.items.ZULFIQAR,
        },
            -- AXES
        {
            xi.items.NIBIRU_TABAR,
            xi.items.SKULLRENDER,
            xi.items.DIGIRBALAG,
        },
            -- GREAT AXES
        {
            xi.items.NIBIRU_CHOPPER,
            xi.items.ROUTER,
            xi.items.INSTIGATOR,
            xi.items.AGANOSHE,
        },
            -- POLEARMS
        {
            xi.items.NIBIRU_LANCE,
            xi.items.ANNEALED_LANCE,
            xi.items.RHOMPHAIA,
            xi.items.REIENKYO,
        },
            -- SCYTHES
        {
            xi.items.NIBIRU_SICKLE,
            xi.items.DEATHBANE,
            xi.items.OBSCHINE,
        },
            -- KATANAS
        {
            xi.items.MIJIN,
            xi.items.AIZUSHINTOGO,
            xi.items.KANARIA,
        },
            -- GREAT KATANAS
        {
            xi.items.SENSUI,
            xi.items.ICHIGOHITOFURI,
            xi.items.UMARU,
        },
            -- CLUBS
        {
            xi.items.NIBIRU_CUDGEL,
            xi.items.QUELLER_ROD,
            xi.items.SOLSTICE,
            xi.items.SUCELLUS,
            xi.items.GADA,
        },
            -- STAVES
        {
            xi.items.NIBIRU_STAFF,
            xi.items.ESPIRITUS,
            xi.items.AKADEMOS,
            xi.items.LATHI,
            xi.items.GRIOAVOLR,
        },
            -- THROWING WEAPONS
        {
            xi.items.SERAPHIC_AMPULLA,
            xi.items.GRENADE_CORE,
            xi.items.SAPIENCE_ORB,
            xi.items.FALCON_EYE,
            xi.items.ALBIN_BANE,
            xi.items.AMAR_CLUSTER,
            xi.items.HYDROCERA,
            xi.items.MANTOPTERA_EYE,
            xi.items.EXPEDITIOUS_PINION,
            xi.items.PEMPHREDO_TATHLUM,
        },
            -- BOWS
        {
            xi.items.NIBIRU_BOW,
            xi.items.VIJAYA_BOW,
            xi.items.TELLER,
        },
            -- GUNS
        {
            xi.items.NIBIRU_GUN,
            xi.items.COMPENSATOR,
            xi.items.NONE, -- Gap slot 3
            xi.items.HOLLIDAY,
        },
            -- SHIELDS
        {
            xi.items.NIBIRU_SHIELD,
        },
            -- INSTRUMENTS
        {
            xi.items.NIBIRU_HARP,
        },
            -- GRIPS
        {
            xi.items.CLEMENCY_GRIP,
            xi.items.WILLPOWER_GRIP,
            xi.items.FOREFATHERS_GRIP,
            xi.items.GIUOCO_GRIP,
            xi.items.BALARAMA_GRIP,
            xi.items.NIOBID_STRAP,
            xi.items.POTENT_GRIP,
        },
            -- HEADGEAR
        {
            xi.items.ESCHITE_HELM,
            xi.items.PSYCLOTH_TIARA,
            xi.items.RAWHIDE_MASK,
            xi.items.DESPAIR_HELM,
            xi.items.VANYA_HOOD,
            xi.items.PURSUERS_BERET,
            xi.items.NAGA_SOMEN,
            xi.items.SKORMOTH_MASK,
            xi.items.ODYSSEAN_HELM,
            xi.items.VALOROUS_MASK,
            xi.items.HERCULEAN_HELM,
            xi.items.MERLINIC_HOOD,
            xi.items.CHIRONIC_HAT,
        },
            -- CHEST ARMOR
        {
            xi.items.ESCHITE_BREASTPLATE,
            xi.items.PSYCLOTH_VEST,
            xi.items.RAWHIDE_VEST,
            xi.items.DESPAIR_MAIL,
            xi.items.VANYA_ROBE,
            xi.items.PURSUERS_DOUBLET,
            xi.items.NAGA_SAMUE,
            xi.items.SWELLERS_HARNESS,
            xi.items.ONCA_SUIT,
            xi.items.KUBIRA_MEIKOGAI,
            xi.items.ANNOINTED_KALASIRIS,
            xi.items.MAKORA_MEIKOGAI,
            xi.items.ENFORCERS_HARNESS,
            xi.items.UAC_JERKIN,
            xi.items.SHANGO_ROBE,
            xi.items.ABNOBA_KAFTAN,
        },
            -- GLOVES AND GAUNTLETS
        {
            xi.items.NAGA_TEKKO,
            xi.items.ESCHITE_GAUNTLETS,
            xi.items.PSYCLOTH_MANILLAS,
            xi.items.RAWHIDE_GLOVES,
            xi.items.DESPAIR_FINGER_GLOVES,
            xi.items.VANYA_CUFFS,
            xi.items.PURSUERS_CUFFS,
            xi.items.SHRIEKERS_CUFFS,
            xi.items.KURYS_GLOVES,
            xi.items.ODYSSEAN_GAUNTLETS,
            xi.items.VALOROUS_MITTS,
            xi.items.HERCULEAN_GLOVES,
            xi.items.MERLINIC_DASTANAS,
            xi.items.CHIRONIC_GLOVES,
        },
            -- LEG ARMOR
        {
            xi.items.NAGA_HAKAMA,
            xi.items.ESCHITE_CUISSES,
            xi.items.PSYCLOTH_LAPPAS,
            xi.items.RAWHIDE_TROUSERS,
            xi.items.DESPAIR_CUISSES,
            xi.items.VANYA_SLOPS,
            xi.items.PURSUERS_PANTS,
            xi.items.DOYEN_PANTS,
            xi.items.OBATALA_SUBLIGAR,
            xi.items.SELVANS_SUBLIGAR,
            xi.items.ODYSSEAN_CUISSES,
            xi.items.VALOROUS_HOSE,
            xi.items.HERCULEAN_TROUSERS,
            xi.items.MERLINIC_SHALWAR,
            xi.items.CHIRONIC_HOSE,
        },
            -- BOOTS AND GREAVES
        {
            xi.items.PURSUERS_GAITERS,
            xi.items.NAGA_KYAHAN,
            xi.items.ESCHITE_GREAVES,
            xi.items.PSYCLOTH_BOOTS,
            xi.items.RAWHIDE_BOOTS,
            xi.items.DESPAIR_GREAVES,
            xi.items.VANYA_CLOGS,
            xi.items.INSPIRITED_BOOTS,
            xi.items.TUTYR_SABOTS,
            xi.items.ODYSSEAN_GREAVES,
            xi.items.VALOROUS_GREAVES,
            xi.items.HERCULEAN_BOOTS,
            xi.items.MERLINIC_CRACKOWS,
            xi.items.CHIRONIC_SLIPPERS,
        },
            -- NECK PIECES
        {
            xi.items.MARKED_GORGET,
            xi.items.SUBTLETY_SPECTACLES,
            xi.items.DAMPENERS_TORQUE,
            xi.items.EMPATH_NECKLACE,
            xi.items.RETI_PENDANT,
            xi.items.DIEMER_GORGET,
            xi.items.CARO_NECKLACE,
            xi.items.NODENS_GORGET,
            xi.items.CLOTHARIUS_TORQUE,
            xi.items.DEINO_COLLAR,
            xi.items.HOMERIC_GORGET,
        },
            -- EARRINGS
        {
            xi.items.MENDICANTS_EARRING,
            xi.items.INFUSED_EARRING,
            xi.items.CALAMITOUS_EARRING,
            xi.items.HERMETIC_EARRING,
            xi.items.HALASZ_EARRING,
            xi.items.ASSUAGE_EARRING,
            xi.items.ISHVARA_EARRING,
            xi.items.EVANS_EARRING,
            xi.items.LEMPO_EARRING,
            xi.items.THUREOUS_EARRING,
            xi.items.DIGNITARYS_EARRING,
        },
            -- BELTS AND SASHES
        {
            xi.items.LUCIDITY_SASH,
            xi.items.SINEW_BELT,
            xi.items.ESCHAN_STONE,
            xi.items.GRUNFELD_ROPE,
            xi.items.POROUS_ROPE,
            xi.items.SULLA_BELT,
            xi.items.YEMAYA_BELT,
            xi.items.CHANNELERS_STONE,
            xi.items.ASKLEPIAN_BELT,
            xi.items.SARISSAPHOROI_BELT,
        },
            -- RINGS
        {
            xi.items.OVERBEARING_RING,
            xi.items.RESONANCE_RING,
            xi.items.PURITY_RING,
            xi.items.WARDENS_RING,
            xi.items.PETROV_RING,
            xi.items.FORTIFIED_RING,
            xi.items.VERTIGO_RING,
            xi.items.EVANESCENCE_RING,
            xi.items.BEGRUDGING_RING,
            xi.items.APATE_RING,
            xi.items.PERSIS_RING,
        },
            -- CAPES AND CLOAKS
        {
            xi.items.DISPERSERS_CAPE,
            xi.items.THAUMATURGES_CAPE,
            xi.items.PENETRATING_CAPE,
            xi.items.PHILIDOR_MANTLE,
            xi.items.SOKOLSKI_MANTLE,
            xi.items.QUARREL_MANTLE,
            xi.items.XUCAU_MANTLE,
            xi.items.TANTALIC_CAPE,
            xi.items.SCINTILLATING_CAPE,
            xi.items.PHALANGITE_MANTLE,
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
            xi.items.GRENADE_CORE,
            xi.items.SERAPHIC_AMPULLA,
            xi.items.ALBIN_BANE,
            xi.items.AMAR_CLUSTER,
            xi.items.HYDROCERA,
            xi.items.MANTOPTERA_EYE,
        },

        { --[[ Null Menu 14 --]] },
        { --[[ Null Menu 15 --]] },
        { --[[ Null Menu 16 --]] },
        { --[[ Null Menu 17 --]] },

            -- GRIPS
        {
            xi.items.WILLPOWER_GRIP,
            xi.items.CLEMENCY_GRIP,
            xi.items.GIUOCO_GRIP,
            xi.items.BALARAMA_GRIP,
        },
            -- HEADGEAR
        {
            xi.items.ESCHITE_HELM,
            xi.items.VANYA_HOOD,
            xi.items.PSYCLOTH_TIARA,
            xi.items.DESPAIR_HELM,
            xi.items.PURSUERS_BERET,
            xi.items.RAWHIDE_MASK,
            xi.items.NAGA_SOMEN,
        },
            -- CHEST ARMOR
        {
            xi.items.VANYA_ROBE,
            xi.items.ESCHITE_BREASTPLATE,
            xi.items.PSYCLOTH_VEST,
            xi.items.DESPAIR_MAIL,
            xi.items.PURSUERS_DOUBLET,
            xi.items.RAWHIDE_VEST,
            xi.items.NAGA_SAMUE,
        },
            -- GLOVES AND GAUNTLETS
        {
            xi.items.VANYA_CUFFS,
            xi.items.ESCHITE_GAUNTLETS,
            xi.items.PSYCLOTH_MANILLAS,
            xi.items.DESPAIR_FINGER_GLOVES,
            xi.items.PURSUERS_CUFFS,
            xi.items.RAWHIDE_GLOVES,
            xi.items.NAGA_TEKKO,
        },
            -- LEG ARMOR
        {
            xi.items.VANYA_SLOPS,
            xi.items.ESCHITE_CUISSES,
            xi.items.PSYCLOTH_LAPPAS,
            xi.items.DESPAIR_CUISSES,
            xi.items.PURSUERS_PANTS,
            xi.items.RAWHIDE_TROUSERS,
            xi.items.NAGA_HAKAMA,
        },
            -- BOOTS AND GREAVES
        {
            xi.items.VANYA_CLOGS,
            xi.items.ESCHITE_GREAVES,
            xi.items.PSYCLOTH_BOOTS,
            xi.items.DESPAIR_GREAVES,
            xi.items.PURSUERS_GAITERS,
            xi.items.RAWHIDE_BOOTS,
            xi.items.NAGA_KYAHAN,
        },
            -- NECK PIECES
        {
            xi.items.SUBTLETY_SPECTACLES,
            xi.items.MARKED_GORGET,
            xi.items.RETI_PENDANT,
            xi.items.DIEMER_GORGET,
            xi.items.CARO_NECKLACE,
            xi.items.NODENS_GORGET,
        },
            -- EARRINGS
        {
            xi.items.INFUSED_EARRING,
            xi.items.MENDICANTS_EARRING,
            xi.items.HALASZ_EARRING,
            xi.items.ASSUAGE_EARRING,
            xi.items.ISHVARA_EARRING,
            xi.items.EVANS_EARRING,
        },
            -- BELTS AND SASHES
        {
            xi.items.LUCIDITY_SASH,
            xi.items.GRUNFELD_ROPE,
            xi.items.POROUS_ROPE,
            xi.items.SULLA_BELT,
        },
            -- RINGS
        {
            xi.items.OVERBEARING_RING,
            xi.items.RESONANCE_RING,
            xi.items.PETROV_RING,
            xi.items.FORTIFIED_RING,
            xi.items.VERTIGO_RING,
            xi.items.EVANESCENCE_RING,
        },
            -- CAPES AND CLOAKS
        {
            xi.items.DISPERSERS_CAPE,
            xi.items.PHILIDOR_MANTLE,
            xi.items.SOKOLSKI_MANTLE,
            xi.items.QUARREL_MANTLE,
        },
    },
    --[[
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

local getIndexParams = function(list, option)
    local idxAlt1  = 0
    local idxAlt2  = 0
    local keyItems = 0

    if
        list == 12 or                   -- I-Seal
        list == 22 or                   -- AW-WK
        list == 26 or                   -- I-Skill
        (list >= 32 and list <= 34) or  -- AW-Mis / AW-Vgr / AW-VgrII
        (list >= 37 and list <= 39)     -- AW-GFIII / AW-GFII / AW-GF
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

local getItemSelection = function(list, idx, idxAlt1, idxAlt2)
    local item = 0

    if
        list == 12 or                   -- I-Seal
        list == 22 or                   -- AW-WK
        list == 26 or                   -- I-Skill
        (list >= 32 and list <= 34) or  -- AW-Mis / AW-Vgr / AW-VgrII
        (list >= 37 and list <= 39)     -- AW-GFIII / AW-GFII / AW-GF
    then
        item = itemList[list][idxAlt1][idxAlt2]

        if list == 12 then  -- Item, Quantity
            item = { item } -- Tabling here to save 100 pairs of { }
        end
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
        player:PrintToPlayer(string.format("DEBUG: list: %u, idx: %u, submenuid %u, slot: %u", list, idx, idxAlt1, idxAlt2), xi.msg.channel.SYSTEM_3)
    else
        print(string.format("DEBUG: list: %u, idx: %u, submenuid %u, slot: %u", list, idx, idxAlt1, idxAlt2))
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
        local altIDs    = getIndexParams(list, option)
        local idxAlt1   = altIDs[1]
        local idxAlt2   = altIDs[2]
        local keyItems  = altIDs[3]

        if list > 0 and idx == 0 then
            player:addKeyItem(listToKeyItem(list))
        elseif list > 0 and idx > 0 then
            local item = getItemSelection(list, idx, idxAlt1, idxAlt2)

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
