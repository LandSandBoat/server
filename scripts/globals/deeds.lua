-----------------------------------
-- Deeds of Heroism (A.M.A.N. Validator)
-----------------------------------
-- Bastok Markets      : !pos -338.18 -10 -180.19 235
-- Southern San d'Oria : !pos -83.07 1 -55.58 230
-- Windurst Woods      : !pos 89.9 -4.2 -47.63 241
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.deeds = xi.deeds or {}

local validatorNpcEvents =
{
    [xi.zone.BASTOK_MARKETS    ] = 669,
    [xi.zone.SOUTHERN_SAN_DORIA] = 3610,
    [xi.zone.WINDURST_WOODS    ] = 976,
}

-- Raw Rewards from AMAN Validator
-- NOTE: These tables are not configurable, and the client will not change
-- based on the data provided below.
local validatorRewards =
{
    [  1] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  7 },
    [  2] = { itemId    = xi.item.MOGGIEBAG,                      qty =  1 },
    [  3] = { itemId    = xi.item.ENDORSEMENT_RING,               qty =  1 },
    [  4] = { itemId    = xi.item.THEMIS_ORB,                     qty =  1 },

    [  5] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty = 14 },
    [  6] = { itemId    = xi.item.MOOGLES_LARGESSE,               qty =  1 },
    [  7] = { keyItemId = xi.ki.DEED_VOUCHER                                },
    [  8] = { itemId    = xi.item.PHOBOS_ORB,                     qty =  1 },

    [  9] = { itemId    = xi.item.MOGRATUITY,                     qty =  1 },
    [ 10] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 11] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_FEET                    },
    [ 12] = { itemId    = xi.item.DEIMOS_ORB,                     qty =  1 },

    [ 13] = { itemId    = xi.item.POUCH_OF_MOOGLE_MOOLAH,         qty =  1 },
    [ 14] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 15] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_HANDS                   },
    [ 16] = { itemId    = xi.item.ZELOS_ORB,                      qty =  1 },

    [ 17] = { itemId    = xi.item.MOG_KUPON_W_PULSE,              qty =  1 },
    [ 18] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 19] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_HEAD                    },
    [ 20] = { itemId    = xi.item.BIA_ORB,                        qty =  1 },

    [ 21] = { itemId    = xi.item.MOGGIE_GOODIE_BAG,              qty =  1 },
    [ 22] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 23] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_LEGS                    },
    [ 24] = { itemId    = xi.item.MICROCOSMIC_ORB,                qty =  1 },

    [ 25] = { itemId    = xi.item.GOBBIE_GOODIE_BAG,              qty =  1 },
    [ 26] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 27] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_CHEST                   },
    [ 28] = { itemId    = xi.item.MACROCOSMIC_ORB,                qty =  1 },

    [ 29] = { itemId    = xi.item.AMBUSCADE_VOUCHER_WEAPON,       qty =  1 },
    [ 30] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 31] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_FEET                    },
    [ 32] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [ 33] = { itemId    = xi.item.WYRMKING_MASQUE,                qty =  1 },
    [ 34] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 35] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_HANDS                   },
    [ 36] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [ 37] = { itemId    = xi.item.WYRMKING_SUIT,                  qty =  1 },
    [ 38] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 39] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_HEAD                    },
    [ 40] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [ 41] = { itemId    = xi.item.AKITU_SHIRT,                    qty =  1 },
    [ 42] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 43] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_LEGS                    },
    [ 44] = { itemId    = xi.item.VENUS_ORB,                      qty =  1 },

    [ 45] = { itemId    = xi.item.CRUSTACEAN_SHIRT,               qty =  1 },
    [ 46] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 47] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_CHEST                   },
    [ 48] = { itemId    = xi.item.CIPHER_OF_MONBERAUXS_ALTER_EGO, qty =  1 },

    [ 49] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty = 10 },
    [ 50] = { itemId    = xi.item.MAATS_CONCOCTION,               qty =  1 },
    [ 51] = { itemId    = xi.item.DIAL_KEY_FO,                    qty =  5 },
    [ 52] = { itemId    = xi.item.THEMIS_ORB,                     qty =  1 },

    [ 53] = { itemId    = xi.item.ABDHALJS_SEAL,                  qty =  5 },
    [ 54] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 55] = { keyItemId = xi.ki.DEED_TOKEN                                  },
    [ 56] = { itemId    = xi.item.PHOBOS_ORB,                     qty =  1 },

    [ 57] = { itemId    = xi.item.DECANTER_INGRID,                qty =  1 },
    [ 58] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 59] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_FEET                      },
    [ 60] = { itemId    = xi.item.DEIMOS_ORB,                     qty =  1 },

    [ 61] = { itemId    = xi.item.DECANTER_DARRCUILN,             qty =  1 },
    [ 62] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 63] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_HANDS                     },
    [ 64] = { itemId    = xi.item.ZELOS_ORB,                      qty =  1 },

    [ 65] = { itemId    = xi.item.DECANTER_ARCIELA,               qty =  1 },
    [ 66] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 67] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_HEAD                      },
    [ 68] = { itemId    = xi.item.BIA_ORB,                        qty =  1 },

    [ 69] = { itemId    = xi.item.DIAL_KEY_AB,                    qty =  5 },
    [ 70] = { itemId    = xi.item.MICROCOSMIC_ORB,                qty =  1 },
    [ 71] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_LEGS                      },
    [ 72] = { keyItemId = xi.ki.PRIMER_ON_MARTIAL_TECHNIQUES                },

    [ 73] = { itemId    = xi.item.DECANTER_MORIMAR,               qty =  1 },
    [ 74] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 75] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_CHEST                     },
    [ 76] = { itemId    = xi.item.MACROCOSMIC_ORB,                qty =  1 },

    [ 77] = { itemId    = xi.item.DECANTER_ROSULATIA,             qty =  1 },
    [ 78] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 79] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_FEET                      },
    [ 80] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [ 81] = { itemId    = xi.item.DECANTER_TEODOR,                qty =  1 },
    [ 82] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 83] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_HANDS                     },
    [ 84] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [ 85] = { itemId    = xi.item.DECANTER_SAJJAKA,               qty =  1 },
    [ 86] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 87] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_HEAD                      },
    [ 88] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [ 89] = { itemId    = xi.item.DECANTER_ARCIELA_II,            qty =  1 },
    [ 90] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 91] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_LEGS                      },
    [ 92] = { itemId    = xi.item.VENUS_ORB,                      qty =  1 },

    [ 93] = { itemId    = xi.item.DECANTER_AUGUST,                qty =  1 },
    [ 94] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [ 95] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_CHEST                     },
    [ 96] = { keyItemId = xi.ki.TREATISE_ON_MARTIAL_TECHNIQUES              },

    [ 97] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [ 98] = { itemId    = xi.item.ABDHALJS_SEAL,                  qty =  1 },
    [ 99] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [100] = { itemId    = xi.item.SUPER_RERAISER_TANK,            qty =  1 },

    [101] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [102] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [103] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [104] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [105] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [106] = { itemId    = xi.item.ABDHALJS_SEAL,                  qty =  3 },
    [107] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [108] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [109] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [110] = { itemId    = xi.item.DIAL_KEY_FO,                    qty =  5 },
    [111] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [112] = { itemId    = xi.item.VENUS_ORB,                      qty =  1 },

    [113] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  1 },
    [114] = { itemId    = xi.item.ABDHALJS_SEAL,                  qty =  3 },
    [115] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [116] = { itemId    = xi.item.ABRIDGED_FIENDISH_COMPENDIUM,   qty =  1 },

    [117] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [118] = { itemId    = xi.item.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [119] = { itemId    = xi.item.GREEN_MOG_PELL,                 qty =  1 },
    [120] = { itemId    = xi.item.MAATS_CONCOCTION,               qty =  1 },

    [121] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [122] = { itemId    = xi.item.ABDHALJS_SEAL,                  qty =  3 },
    [123] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [124] = { itemId    = xi.item.MOG_KUPON_W_PULSE,              qty =  1 },

    [125] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [126] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [127] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [128] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [129] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [130] = { itemId    = xi.item.ABDHALJS_SEAL,                  qty =  3 },
    [131] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [132] = { itemId    = xi.item.MARS_ORB,                       qty =  1 },

    [133] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [134] = { itemId    = xi.item.DIAL_KEY_FO,                    qty =  5 },
    [135] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [136] = { itemId    = xi.item.VENUS_ORB,                      qty =  1 },

    [137] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [138] = { itemId    = xi.item.ABDHALJS_SEAL,                  qty =  3 },
    [139] = { itemId    = xi.item.MAATS_MIX,                      qty =  1 },
    [140] = { itemId    = xi.item.PANDEMONIUM_KEY,                qty =  1 },

    [141] = { itemId    = xi.item.COPPER_AMAN_VOUCHER,            qty =  3 },
    [142] = { itemId    = xi.item.DIAL_KEY_ANV,                   qty =  5 },
    [143] = { itemId    = xi.item.GREEN_MOG_PELL,                 qty =  1 },
    [144] = { itemId    = xi.item.MAATS_CONCOCTION,               qty =  1 },
}

-- Key items by Bit to determine storedVoucher Mask
-- NOTE: This order should not be changed, and does not follow the order
-- in which the player is eligible to purchase.
local voucherKeyItems =
{
    xi.ki.DEED_VOUCHER,
    xi.ki.DEED_VOUCHER_PLUS_1_HEAD,
    xi.ki.DEED_VOUCHER_PLUS_1_CHEST,
    xi.ki.DEED_VOUCHER_PLUS_1_HANDS,
    xi.ki.DEED_VOUCHER_PLUS_1_LEGS,
    xi.ki.DEED_VOUCHER_PLUS_1_FEET,
    xi.ki.DEED_VOUCHER_PLUS_2_HEAD,
    xi.ki.DEED_VOUCHER_PLUS_2_CHEST,
    xi.ki.DEED_VOUCHER_PLUS_2_HANDS,
    xi.ki.DEED_VOUCHER_PLUS_2_LEGS,
    xi.ki.DEED_VOUCHER_PLUS_2_FEET,
    xi.ki.DEED_TOKEN,
    xi.ki.DEED_TOKEN_PLUS_1_HEAD,
    xi.ki.DEED_TOKEN_PLUS_1_CHEST,
    xi.ki.DEED_TOKEN_PLUS_1_HANDS,
    xi.ki.DEED_TOKEN_PLUS_1_LEGS,
    xi.ki.DEED_TOKEN_PLUS_1_FEET,
    xi.ki.DEED_TOKEN_PLUS_2_HEAD,
    xi.ki.DEED_TOKEN_PLUS_2_CHEST,
    xi.ki.DEED_TOKEN_PLUS_2_HANDS,
    xi.ki.DEED_TOKEN_PLUS_2_LEGS,
    xi.ki.DEED_TOKEN_PLUS_2_FEET,
}

-- Subtables to determine what items can be rewarded per store voucher.
-- Sub-keys are by Job ID in the event, which currently align to the Job
-- enum - 1.  In this case, not using the enum in order to specify that
-- this is strictly received from the event itself.
local voucherData =
{
    [0] = -- Deed Voucher
    {
        [0] =
        {
            xi.item.PUMMELERS_MASK,
            xi.item.PUMMELERS_LORICA,
            xi.item.PUMMELERS_MUFFLERS,
            xi.item.PUMMELERS_CUISSES,
            xi.item.PUMMELERS_CALLIGAE,
        },

        [1] =
        {
            xi.item.ANCHORITES_CROWN,
            xi.item.ANCHORITES_CYCLAS,
            xi.item.ANCHORITES_GLOVES,
            xi.item.ANCHORITES_HOSE,
            xi.item.ANCHORITES_GAITERS,
        },

        [2] =
        {
            xi.item.THEOPHANY_CAP,
            xi.item.THEOPHANY_BRIAULT,
            xi.item.THEOPHANY_MITTS,
            xi.item.THEOPHANY_PANTALOONS,
            xi.item.THEOPHANY_DUCKBILLS,
        },

        [3] =
        {
            xi.item.SPAEKONAS_PETASOS,
            xi.item.SPAEKONAS_COAT,
            xi.item.SPAEKONAS_GLOVES,
            xi.item.SPAEKONAS_TONBAN,
            xi.item.SPAEKONAS_SABOTS,
        },

        [4] =
        {
            xi.item.ATROPHY_CHAPEAU,
            xi.item.ATROPHY_TABARD,
            xi.item.ATROPHY_GLOVES,
            xi.item.ATROPHY_TIGHTS,
            xi.item.ATROPHY_BOOTS,
        },

        [5] =
        {
            xi.item.PILLAGERS_BONNET,
            xi.item.PILLAGERS_VEST,
            xi.item.PILLAGERS_ARMLETS,
            xi.item.PILLAGERS_CULOTTES,
            xi.item.PILLAGERS_POULAINES,
        },

        [6] =
        {
            xi.item.REVERENCE_CORONET,
            xi.item.REVERENCE_SURCOAT,
            xi.item.REVERENCE_GAUNTLETS,
            xi.item.REVERENCE_BREECHES,
            xi.item.REVERENCE_LEGGINGS,
        },

        [7] =
        {
            xi.item.IGNOMINY_BURGEONET,
            xi.item.IGNOMINY_CUIRASS,
            xi.item.IGNOMINY_GAUNTLETS,
            xi.item.IGNOMINY_FLANCHARD,
            xi.item.IGNOMINY_SOLLERETS,
        },

        [8] =
        {
            xi.item.TOTEMIC_HELM,
            xi.item.TOTEMIC_JACKCOAT,
            xi.item.TOTEMIC_GLOVES,
            xi.item.TOTEMIC_TROUSERS,
            xi.item.TOTEMIC_GAITERS,
        },

        [9] =
        {
            xi.item.BRIOSO_ROUNDLET,
            xi.item.BRIOSO_JUSTAUCORPS,
            xi.item.BRIOSO_CUFFS,
            xi.item.BRIOSO_CANNIONS,
            xi.item.BRIOSO_SLIPPERS,
        },

        [10] =
        {
            xi.item.ORION_BERET,
            xi.item.ORION_JERKIN,
            xi.item.ORION_BRACERS,
            xi.item.ORION_BRACCAE,
            xi.item.ORION_SOCKS,
        },

        [11] =
        {
            xi.item.WAKIDO_KABUTO,
            xi.item.WAKIDO_DOMARU,
            xi.item.WAKIDO_KOTE,
            xi.item.WAKIDO_HAIDATE,
            xi.item.WAKIDO_SUNE_ATE,
        },

        [12] =
        {
            xi.item.HACHIYA_HATSUBURI,
            xi.item.HACHIYA_CHAINMAIL,
            xi.item.HACHIYA_TEKKO,
            xi.item.HACHIYA_HAKAMA,
            xi.item.HACHIYA_KYAHAN,
        },

        [13] =
        {
            xi.item.VISHAP_ARMET,
            xi.item.VISHAP_MAIL,
            xi.item.VISHAP_FINGER_GAUNTLETS,
            xi.item.VISHAP_BRAIS,
            xi.item.VISHAP_GREAVES,
        },

        [14] =
        {
            xi.item.CONVOKERS_HORN,
            xi.item.CONVOKERS_DOUBLET,
            xi.item.CONVOKERS_BRACERS,
            xi.item.CONVOKERS_SPATS,
            xi.item.CONVOKERS_PIGACHES,
        },

        [15] =
        {
            xi.item.ASSIMILATORS_KEFFIYEH,
            xi.item.ASSIMILATORS_JUBBAH,
            xi.item.ASSIMILATORS_BAZUBANDS,
            xi.item.ASSIMILATORS_SHALWAR,
            xi.item.ASSIMILATORS_CHARUQS,
        },

        [16] =
        {
            xi.item.LAKSAMANAS_TRICORNE,
            xi.item.LAKSAMANAS_FRAC,
            xi.item.LAKSAMANAS_GANTS,
            xi.item.LAKSAMANAS_TREWS,
            xi.item.LAKSAMANAS_BOTTES,
        },

        [17] =
        {
            xi.item.FOIRE_TAJ,
            xi.item.FOIRE_TOBE,
            xi.item.FOIRE_DASTANAS,
            xi.item.FOIRE_CHURIDARS,
            xi.item.FOIRE_BABOUCHES,
        },

        [18] =
        {
            genderSpecific = true,

            [0] =
            {
                xi.item.MAXIXI_TIARA_F,
                xi.item.MAXIXI_CASAQUE_F,
                xi.item.MAXIXI_BANGLES_F,
                xi.item.MAXIXI_TIGHTS_F,
                xi.item.MAXIXI_TOE_SHOES_F,
            },

            [1] =
            {
                xi.item.MAXIXI_TIARA_M,
                xi.item.MAXIXI_CASAQUE_M,
                xi.item.MAXIXI_BANGLES_M,
                xi.item.MAXIXI_TIGHTS_M,
                xi.item.MAXIXI_TOE_SHOES_M,
            },
        },

        [19] =
        {
            xi.item.ACADEMICS_MORTARBOARD,
            xi.item.ACADEMICS_GOWN,
            xi.item.ACADEMICS_BRACERS,
            xi.item.ACADEMICS_PANTS,
            xi.item.ACADEMICS_LOAFERS,
        },

        [20] =
        {
            xi.item.GEOMANCY_GALERO,
            xi.item.GEOMANCY_TUNIC,
            xi.item.GEOMANCY_MITAINES,
            xi.item.GEOMANCY_PANTS,
            xi.item.GEOMANCY_SANDALS,
        },

        [21] =
        {
            xi.item.RUNEIST_BANDEAU,
            xi.item.RUNEIST_COAT,
            xi.item.RUNEIST_MITONS,
            xi.item.RUNEIST_TROUSERS,
            xi.item.RUNEIST_BOTTES,
        },
    },

    [1] = -- Deed Voucher +1: Head
    {
        [ 0] = { xi.item.PUMMELERS_MASK_P1        },
        [ 1] = { xi.item.ANCHORITES_CROWN_P1      },
        [ 2] = { xi.item.THEOPHANY_CAP_P1         },
        [ 3] = { xi.item.SPAEKONAS_PETASOS_P1     },
        [ 4] = { xi.item.ATROPHY_CHAPEAU_P1       },
        [ 5] = { xi.item.PILLAGERS_BONNET_P1      },
        [ 6] = { xi.item.REVERENCE_CORONET_P1     },
        [ 7] = { xi.item.IGNOMINY_BURGEONET_P1    },
        [ 8] = { xi.item.TOTEMIC_HELM_P1          },
        [ 9] = { xi.item.BRIOSO_ROUNDLET_P1       },
        [10] = { xi.item.ORION_BERET_P1           },
        [11] = { xi.item.WAKIDO_KABUTO_P1         },
        [12] = { xi.item.HACHIYA_HATSUBURI_P1     },
        [13] = { xi.item.VISHAP_ARMET_P1          },
        [14] = { xi.item.CONVOKERS_HORN_P1        },
        [15] = { xi.item.ASSIMILATORS_KEFFIYEH_P1 },
        [16] = { xi.item.LAKSAMANAS_TRICORNE_P1   },
        [17] = { xi.item.FOIRE_TAJ_P1             },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_TIARA_F_P1 },
            [1] = { xi.item.MAXIXI_TIARA_M_P1 },
        },

        [19] = { xi.item.ACADEMICS_MORTARBOARD_P1 },
        [20] = { xi.item.GEOMANCY_GALERO_P1       },
        [21] = { xi.item.RUNEIST_BANDEAU_P1       },
    },

    [2] = -- Deed Voucher +1: Chest
    {
        [ 0] = { xi.item.PUMMELERS_LORICA_P1    },
        [ 1] = { xi.item.ANCHORITES_CYCLAS_P1   },
        [ 2] = { xi.item.THEOPHANY_BRIAULT_P1   },
        [ 3] = { xi.item.SPAEKONAS_COAT_P1      },
        [ 4] = { xi.item.ATROPHY_TABARD_P1      },
        [ 5] = { xi.item.PILLAGERS_VEST_P1      },
        [ 6] = { xi.item.REVERENCE_SURCOAT_P1   },
        [ 7] = { xi.item.IGNOMINY_CUIRASS_P1    },
        [ 8] = { xi.item.TOTEMIC_JACKCOAT_P1    },
        [ 9] = { xi.item.BRIOSO_JUSTAUCORPS_P1  },
        [10] = { xi.item.ORION_JERKIN_P1        },
        [11] = { xi.item.WAKIDO_DOMARU_P1       },
        [12] = { xi.item.HACHIYA_CHAINMAIL_P1   },
        [13] = { xi.item.VISHAP_MAIL_P1         },
        [14] = { xi.item.CONVOKERS_DOUBLET_P1   },
        [15] = { xi.item.ASSIMILATORS_JUBBAH_P1 },
        [16] = { xi.item.LAKSAMANAS_FRAC_P1     },
        [17] = { xi.item.FOIRE_TOBE_P1          },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_CASAQUE_F_P1 },
            [1] = { xi.item.MAXIXI_CASAQUE_M_P1 },
        },

        [19] = { xi.item.ACADEMICS_GOWN_P1 },
        [20] = { xi.item.GEOMANCY_TUNIC_P1 },
        [21] = { xi.item.RUNEIST_COAT_P1   },
    },

    [3] = -- Deed Voucher +1: Hands
    {
        [ 0] = { xi.item.PUMMELERS_MUFFLERS_P1      },
        [ 1] = { xi.item.ANCHORITES_GLOVES_P1       },
        [ 2] = { xi.item.THEOPHANY_MITTS_P1         },
        [ 3] = { xi.item.SPAEKONAS_GLOVES_P1        },
        [ 4] = { xi.item.ATROPHY_GLOVES_P1          },
        [ 5] = { xi.item.PILLAGERS_ARMLETS_P1       },
        [ 6] = { xi.item.REVERENCE_GAUNTLETS_P1     },
        [ 7] = { xi.item.IGNOMINY_GAUNTLETS_P1      },
        [ 8] = { xi.item.TOTEMIC_GLOVES_P1          },
        [ 9] = { xi.item.BRIOSO_CUFFS_P1            },
        [10] = { xi.item.ORION_BRACERS_P1           },
        [11] = { xi.item.WAKIDO_KOTE_P1             },
        [12] = { xi.item.HACHIYA_TEKKO_P1           },
        [13] = { xi.item.VISHAP_FINGER_GAUNTLETS_P1 },
        [14] = { xi.item.CONVOKERS_BRACERS_P1       },
        [15] = { xi.item.ASSIMILATORS_BAZUBANDS_P1  },
        [16] = { xi.item.LAKSAMANAS_GANTS_P1        },
        [17] = { xi.item.FOIRE_DASTANAS_P1          },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_BANGLES_F_P1 },
            [1] = { xi.item.MAXIXI_BANGLES_M_P1 },
        },

        [19] = { xi.item.ACADEMICS_BRACERS_P1 },
        [20] = { xi.item.GEOMANCY_MITAINES_P1 },
        [21] = { xi.item.RUNEIST_MITONS_P1    },
    },

    [4] = -- Deed Voucher +1: Legs
    {
        [ 0] = { xi.item.PUMMELERS_CUISSES_P1    },
        [ 1] = { xi.item.ANCHORITES_HOSE_P1      },
        [ 2] = { xi.item.THEOPHANY_PANTALOONS_P1 },
        [ 3] = { xi.item.SPAEKONAS_TONBAN_P1     },
        [ 4] = { xi.item.ATROPHY_TIGHTS_P1       },
        [ 5] = { xi.item.PILLAGERS_CULOTTES_P1   },
        [ 6] = { xi.item.REVERENCE_BREECHES_P1   },
        [ 7] = { xi.item.IGNOMINY_FLANCHARD_P1   },
        [ 8] = { xi.item.TOTEMIC_TROUSERS_P1     },
        [ 9] = { xi.item.BRIOSO_CANNIONS_P1      },
        [10] = { xi.item.ORION_BRACCAE_P1        },
        [11] = { xi.item.WAKIDO_HAIDATE_P1       },
        [12] = { xi.item.HACHIYA_HAKAMA_P1       },
        [13] = { xi.item.VISHAP_BRAIS_P1         },
        [14] = { xi.item.CONVOKERS_SPATS_P1      },
        [15] = { xi.item.ASSIMILATORS_SHALWAR_P1 },
        [16] = { xi.item.LAKSAMANAS_TREWS_P1     },
        [17] = { xi.item.FOIRE_CHURIDARS_P1      },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_TIGHTS_F_P1 },
            [1] = { xi.item.MAXIXI_TIGHTS_M_P1 },
        },

        [19] = { xi.item.ACADEMICS_PANTS_P1  },
        [20] = { xi.item.GEOMANCY_PANTS_P1   },
        [21] = { xi.item.RUNEIST_TROUSERS_P1 },
    },

    [5] = -- Deed Voucher +1: Feet
    {
        [ 0] = { xi.item.PUMMELERS_CALLIGAE_P1   },
        [ 1] = { xi.item.ANCHORITES_GAITERS_P1   },
        [ 2] = { xi.item.THEOPHANY_DUCKBILLS_P1  },
        [ 3] = { xi.item.SPAEKONAS_SABOTS_P1     },
        [ 4] = { xi.item.ATROPHY_BOOTS_P1        },
        [ 5] = { xi.item.PILLAGERS_POULAINES_P1  },
        [ 6] = { xi.item.REVERENCE_LEGGINGS_P1   },
        [ 7] = { xi.item.IGNOMINY_SOLLERETS_P1   },
        [ 8] = { xi.item.TOTEMIC_GAITERS_P1      },
        [ 9] = { xi.item.BRIOSO_SLIPPERS_P1      },
        [10] = { xi.item.ORION_SOCKS_P1          },
        [11] = { xi.item.WAKIDO_SUNE_ATE_P1      },
        [12] = { xi.item.HACHIYA_KYAHAN_P1       },
        [13] = { xi.item.VISHAP_GREAVES_P1       },
        [14] = { xi.item.CONVOKERS_PIGACHES_P1   },
        [15] = { xi.item.ASSIMILATORS_CHARUQS_P1 },
        [16] = { xi.item.LAKSAMANAS_BOTTES_P1    },
        [17] = { xi.item.FOIRE_BABOUCHES_P1      },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_TOE_SHOES_F_P1 },
            [1] = { xi.item.MAXIXI_TOE_SHOES_M_P1 },
        },

        [19] = { xi.item.ACADEMICS_LOAFERS_P1 },
        [20] = { xi.item.GEOMANCY_SANDALS_P1  },
        [21] = { xi.item.RUNEIST_BOTTES_P1    },
    },

    [6] = -- Deed Voucher +2: Head
    {
        [ 0] = { xi.item.PUMMELERS_MASK_P2        },
        [ 1] = { xi.item.ANCHORITES_CROWN_P2      },
        [ 2] = { xi.item.THEOPHANY_CAP_P2         },
        [ 3] = { xi.item.SPAEKONAS_PETASOS_P2     },
        [ 4] = { xi.item.ATROPHY_CHAPEAU_P2       },
        [ 5] = { xi.item.PILLAGERS_BONNET_P2      },
        [ 6] = { xi.item.REVERENCE_CORONET_P2     },
        [ 7] = { xi.item.IGNOMINY_BURGEONET_P2    },
        [ 8] = { xi.item.TOTEMIC_HELM_P2          },
        [ 9] = { xi.item.BRIOSO_ROUNDLET_P2       },
        [10] = { xi.item.ORION_BERET_P2           },
        [11] = { xi.item.WAKIDO_KABUTO_P2         },
        [12] = { xi.item.HACHIYA_HATSUBURI_P2     },
        [13] = { xi.item.VISHAP_ARMET_P2          },
        [14] = { xi.item.CONVOKERS_HORN_P2        },
        [15] = { xi.item.ASSIMILATORS_KEFFIYEH_P2 },
        [16] = { xi.item.LAKSAMANAS_TRICORNE_P2   },
        [17] = { xi.item.FOIRE_TAJ_P2             },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_TIARA_F_P2 },
            [1] = { xi.item.MAXIXI_TIARA_M_P2 },
        },

        [19] = { xi.item.ACADEMICS_MORTARBOARD_P2 },
        [20] = { xi.item.GEOMANCY_GALERO_P2       },
        [21] = { xi.item.RUNEIST_BANDEAU_P2       },
    },

    [7] = -- Deed Voucher +2: Chest
    {
        [ 0] = { xi.item.PUMMELERS_LORICA_P2    },
        [ 1] = { xi.item.ANCHORITES_CYCLAS_P2   },
        [ 2] = { xi.item.THEOPHANY_BRIAULT_P2   },
        [ 3] = { xi.item.SPAEKONAS_COAT_P2      },
        [ 4] = { xi.item.ATROPHY_TABARD_P2      },
        [ 5] = { xi.item.PILLAGERS_VEST_P2      },
        [ 6] = { xi.item.REVERENCE_SURCOAT_P2   },
        [ 7] = { xi.item.IGNOMINY_CUIRASS_P2    },
        [ 8] = { xi.item.TOTEMIC_JACKCOAT_P2    },
        [ 9] = { xi.item.BRIOSO_JUSTAUCORPS_P2  },
        [10] = { xi.item.ORION_JERKIN_P2        },
        [11] = { xi.item.WAKIDO_DOMARU_P2       },
        [12] = { xi.item.HACHIYA_CHAINMAIL_P2   },
        [13] = { xi.item.VISHAP_MAIL_P2         },
        [14] = { xi.item.CONVOKERS_DOUBLET_P2   },
        [15] = { xi.item.ASSIMILATORS_JUBBAH_P2 },
        [16] = { xi.item.LAKSAMANAS_FRAC_P2     },
        [17] = { xi.item.FOIRE_TOBE_P2          },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_CASAQUE_F_P2 },
            [1] = { xi.item.MAXIXI_CASAQUE_M_P2 },
        },

        [19] = { xi.item.ACADEMICS_GOWN_P2 },
        [20] = { xi.item.GEOMANCY_TUNIC_P2 },
        [21] = { xi.item.RUNEIST_COAT_P2   },
    },

    [8] = -- Deed Voucher +2: Hands
    {
        [ 0] = { xi.item.PUMMELERS_MUFFLERS_P2      },
        [ 1] = { xi.item.ANCHORITES_GLOVES_P2       },
        [ 2] = { xi.item.THEOPHANY_MITTS_P2         },
        [ 3] = { xi.item.SPAEKONAS_GLOVES_P2        },
        [ 4] = { xi.item.ATROPHY_GLOVES_P2          },
        [ 5] = { xi.item.PILLAGERS_ARMLETS_P2       },
        [ 6] = { xi.item.REVERENCE_GAUNTLETS_P2     },
        [ 7] = { xi.item.IGNOMINY_GAUNTLETS_P2      },
        [ 8] = { xi.item.TOTEMIC_GLOVES_P2          },
        [ 9] = { xi.item.BRIOSO_CUFFS_P2            },
        [10] = { xi.item.ORION_BRACERS_P2           },
        [11] = { xi.item.WAKIDO_KOTE_P2             },
        [12] = { xi.item.HACHIYA_TEKKO_P2           },
        [13] = { xi.item.VISHAP_FINGER_GAUNTLETS_P2 },
        [14] = { xi.item.CONVOKERS_BRACERS_P2       },
        [15] = { xi.item.ASSIMILATORS_BAZUBANDS_P2  },
        [16] = { xi.item.LAKSAMANAS_GANTS_P2        },
        [17] = { xi.item.FOIRE_DASTANAS_P2          },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_BANGLES_F_P2 },
            [1] = { xi.item.MAXIXI_BANGLES_M_P2 },
        },

        [19] = { xi.item.ACADEMICS_BRACERS_P2 },
        [20] = { xi.item.GEOMANCY_MITAINES_P2 },
        [21] = { xi.item.RUNEIST_MITONS_P2    },
    },

    [9] = -- Deed Voucher +2: Legs
    {
        [ 0] = { xi.item.PUMMELERS_CUISSES_P2    },
        [ 1] = { xi.item.ANCHORITES_HOSE_P2      },
        [ 2] = { xi.item.THEOPHANY_PANTALOONS_P2 },
        [ 3] = { xi.item.SPAEKONAS_TONBAN_P2     },
        [ 4] = { xi.item.ATROPHY_TIGHTS_P2       },
        [ 5] = { xi.item.PILLAGERS_CULOTTES_P2   },
        [ 6] = { xi.item.REVERENCE_BREECHES_P2   },
        [ 7] = { xi.item.IGNOMINY_FLANCHARD_P2   },
        [ 8] = { xi.item.TOTEMIC_TROUSERS_P2     },
        [ 9] = { xi.item.BRIOSO_CANNIONS_P2      },
        [10] = { xi.item.ORION_BRACCAE_P2        },
        [11] = { xi.item.WAKIDO_HAIDATE_P2       },
        [12] = { xi.item.HACHIYA_HAKAMA_P2       },
        [13] = { xi.item.VISHAP_BRAIS_P2         },
        [14] = { xi.item.CONVOKERS_SPATS_P2      },
        [15] = { xi.item.ASSIMILATORS_SHALWAR_P2 },
        [16] = { xi.item.LAKSAMANAS_TREWS_P2     },
        [17] = { xi.item.FOIRE_CHURIDARS_P2      },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_TIGHTS_F_P2 },
            [1] = { xi.item.MAXIXI_TIGHTS_M_P2 },
        },

        [19] = { xi.item.ACADEMICS_PANTS_P2  },
        [20] = { xi.item.GEOMANCY_PANTS_P2   },
        [21] = { xi.item.RUNEIST_TROUSERS_P2 },
    },

    [10] = -- Deed Voucher +2: Feet
    {
        [ 0] = { xi.item.PUMMELERS_CALLIGAE_P2   },
        [ 1] = { xi.item.ANCHORITES_GAITERS_P2   },
        [ 2] = { xi.item.THEOPHANY_DUCKBILLS_P2  },
        [ 3] = { xi.item.SPAEKONAS_SABOTS_P2     },
        [ 4] = { xi.item.ATROPHY_BOOTS_P2        },
        [ 5] = { xi.item.PILLAGERS_POULAINES_P2  },
        [ 6] = { xi.item.REVERENCE_LEGGINGS_P2   },
        [ 7] = { xi.item.IGNOMINY_SOLLERETS_P2   },
        [ 8] = { xi.item.TOTEMIC_GAITERS_P2      },
        [ 9] = { xi.item.BRIOSO_SLIPPERS_P2      },
        [10] = { xi.item.ORION_SOCKS_P2          },
        [11] = { xi.item.WAKIDO_SUNE_ATE_P2      },
        [12] = { xi.item.HACHIYA_KYAHAN_P2       },
        [13] = { xi.item.VISHAP_GREAVES_P2       },
        [14] = { xi.item.CONVOKERS_PIGACHES_P2   },
        [15] = { xi.item.ASSIMILATORS_CHARUQS_P2 },
        [16] = { xi.item.LAKSAMANAS_BOTTES_P2    },
        [17] = { xi.item.FOIRE_BABOUCHES_P2      },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.item.MAXIXI_TOE_SHOES_F_P2 },
            [1] = { xi.item.MAXIXI_TOE_SHOES_M_P2 },
        },

        [19] = { xi.item.ACADEMICS_LOAFERS_P2 },
        [20] = { xi.item.GEOMANCY_SANDALS_P2  },
        [21] = { xi.item.RUNEIST_BOTTES_P2    },
    },

    [11] = -- Deed Token
    {
        [0] =
        {
            xi.item.AGOGE_MASK,
            xi.item.AGOGE_LORICA,
            xi.item.AGOGE_MUFFLERS,
            xi.item.AGOGE_CUISSES,
            xi.item.AGOGE_CALLIGAE,
        },

        [1] =
        {
            xi.item.HESYCHASTS_CROWN,
            xi.item.HESYCHASTS_CYCLAS,
            xi.item.HESYCHASTS_GLOVES,
            xi.item.HESYCHASTS_HOSE,
            xi.item.HESYCHASTS_GAITERS,
        },

        [2] =
        {
            xi.item.PIETY_CAP,
            xi.item.PIETY_BRIAULT,
            xi.item.PIETY_MITTS,
            xi.item.PIETY_PANTALOONS,
            xi.item.PIETY_DUCKBILLS,
        },

        [3] =
        {
            xi.item.ARCHMAGES_PETASOS,
            xi.item.ARCHMAGES_COAT,
            xi.item.ARCHMAGES_GLOVES,
            xi.item.ARCHMAGES_TONBAN,
            xi.item.ARCHMAGES_SABOTS,
        },

        [4] =
        {
            xi.item.VITIATION_CHAPEAU,
            xi.item.VITIATION_TABARD,
            xi.item.VITIATION_GLOVES,
            xi.item.VITIATION_TIGHTS,
            xi.item.VITIATION_BOOTS,
        },

        [5] =
        {
            xi.item.PLUNDERERS_BONNET,
            xi.item.PLUNDERERS_VEST,
            xi.item.PLUNDERERS_ARMLETS,
            xi.item.PLUNDERERS_CULOTTES,
            xi.item.PLUNDERERS_POULAINES,
        },

        [6] =
        {
            xi.item.CABALLARIUS_CORONET,
            xi.item.CABALLARIUS_SURCOAT,
            xi.item.CABALLARIUS_GAUNTLETS,
            xi.item.CABALLARIUS_BREECHES,
            xi.item.CABALLARIUS_LEGGINGS,
        },

        [7] =
        {
            xi.item.FALLENS_BURGEONET,
            xi.item.FALLENS_CUIRASS,
            xi.item.FALLENS_FINGER_GAUNTLETS,
            xi.item.FALLENS_FLANCHARD,
            xi.item.FALLENS_SOLLERETS,
        },

        [8] =
        {
            xi.item.ANKUSA_HELM,
            xi.item.ANKUSA_JACKCOAT,
            xi.item.ANKUSA_GLOVES,
            xi.item.ANKUSA_TROUSERS,
            xi.item.ANKUSA_GAITERS,
        },

        [9] =
        {
            xi.item.BIHU_ROUNDLET,
            xi.item.BIHU_JUSTAUCORPS,
            xi.item.BIHU_CUFFS,
            xi.item.BIHU_CANNIONS,
            xi.item.BIHU_SLIPPERS,
        },

        [10] =
        {
            xi.item.ARCADIAN_BERET,
            xi.item.ARCADIAN_JERKIN,
            xi.item.ARCADIAN_BRACERS,
            xi.item.ARCADIAN_BRACCAE,
            xi.item.ARCADIAN_SOCKS,
        },

        [11] =
        {
            xi.item.SAKONJI_KABUTO,
            xi.item.SAKONJI_DOMARU,
            xi.item.SAKONJI_KOTE,
            xi.item.SAKONJI_HAIDATE,
            xi.item.SAKONJI_SUNE_ATE,
        },

        [12] =
        {
            xi.item.MOCHIZUKI_HATSUBURI,
            xi.item.MOCHIZUKI_CHAINMAIL,
            xi.item.MOCHIZUKI_TEKKO,
            xi.item.MOCHIZUKI_HAKAMA,
            xi.item.MOCHIZUKI_KYAHAN,
        },

        [13] =
        {
            xi.item.PTEROSLAVER_ARMET,
            xi.item.PTEROSLAVER_MAIL,
            xi.item.PTEROSLAVER_FINGER_GAUNTLETS,
            xi.item.PTEROSLAVER_BRAIS,
            xi.item.PTEROSLAVER_GREAVES,
        },

        [14] =
        {
            xi.item.GLYPHIC_HORN,
            xi.item.GLYPHIC_DOUBLET,
            xi.item.GLYPHIC_BRACERS,
            xi.item.GLYPHIC_SPATS,
            xi.item.GLYPHIC_PIGACHES,
        },

        [15] =
        {
            xi.item.LUHLAZA_KEFFIYEH,
            xi.item.LUHLAZA_JUBBAH,
            xi.item.LUHLAZA_BAZUBANDS,
            xi.item.LUHLAZA_SHALWAR,
            xi.item.LUHLAZA_CHARUQS,
        },

        [16] =
        {
            xi.item.LANUN_TRICORNE,
            xi.item.LANUN_FRAC,
            xi.item.LANUN_GANTS,
            xi.item.LANUN_CULOTTES,
            xi.item.LANUN_BOTTES,
        },

        [17] =
        {
            xi.item.PITRE_TAJ,
            xi.item.PITRE_TOBE,
            xi.item.PITRE_DASTANAS,
            xi.item.PITRE_CHURIDARS,
            xi.item.PITRE_BABOUCHES,
        },

        [18] =
        {
            xi.item.HOROS_TIARA,
            xi.item.HOROS_CASAQUE,
            xi.item.HOROS_BANGLES,
            xi.item.HOROS_TIGHTS,
            xi.item.HOROS_TOE_SHOES,
        },

        [19] =
        {
            xi.item.PEDAGOGY_MORTARBOARD,
            xi.item.PEDAGOGY_GOWN,
            xi.item.PEDAGOGY_BRACERS,
            xi.item.PEDAGOGY_PANTS,
            xi.item.PEDAGOGY_LOAFERS,
        },

        [20] =
        {
            xi.item.BAGUA_GALERO,
            xi.item.BAGUA_TUNIC,
            xi.item.BAGUA_MITAINES,
            xi.item.BAGUA_PANTS,
            xi.item.BAGUA_SANDALS,
        },

        [21] =
        {
            xi.item.FUTHARK_BANDEAU,
            xi.item.FUTHARK_COAT,
            xi.item.FUTHARK_MITONS,
            xi.item.FUTHARK_TROUSERS,
            xi.item.FUTHARK_BOOTS,
        },
    },

    [12] = -- Deed Token +1: Head
    {
        [ 0] = { xi.item.AGOGE_MASK_P1           },
        [ 1] = { xi.item.HESYCHASTS_CROWN_P1     },
        [ 2] = { xi.item.PIETY_CAP_P1            },
        [ 3] = { xi.item.ARCHMAGES_PETASOS_P1    },
        [ 4] = { xi.item.VITIATION_CHAPEAU_P1    },
        [ 5] = { xi.item.PLUNDERERS_BONNET_P1    },
        [ 6] = { xi.item.CABALLARIUS_CORONET_P1  },
        [ 7] = { xi.item.FALLENS_BURGEONET_P1    },
        [ 8] = { xi.item.ANKUSA_HELM_P1          },
        [ 9] = { xi.item.BIHU_ROUNDLET_P1        },
        [10] = { xi.item.ARCADIAN_BERET_P1       },
        [11] = { xi.item.SAKONJI_KABUTO_P1       },
        [12] = { xi.item.MOCHIZUKI_HATSUBURI_P1  },
        [13] = { xi.item.PTEROSLAVER_ARMET_P1    },
        [14] = { xi.item.GLYPHIC_HORN_P1         },
        [15] = { xi.item.LUHLAZA_KEFFIYEH_P1     },
        [16] = { xi.item.LANUN_TRICORNE_P1       },
        [17] = { xi.item.PITRE_TAJ_P1            },
        [18] = { xi.item.HOROS_TIARA_P1          },
        [19] = { xi.item.PEDAGOGY_MORTARBOARD_P1 },
        [20] = { xi.item.BAGUA_GALERO_P1         },
        [21] = { xi.item.FUTHARK_BANDEAU_P1      },
    },

    [13] = -- Deed Token +1: Chest
    {
        [ 0] = { xi.item.AGOGE_LORICA_P1        },
        [ 1] = { xi.item.HESYCHASTS_CYCLAS_P1   },
        [ 2] = { xi.item.PIETY_BRIAULT_P1       },
        [ 3] = { xi.item.ARCHMAGES_COAT_P1      },
        [ 4] = { xi.item.VITIATION_TABARD_P1    },
        [ 5] = { xi.item.PLUNDERERS_VEST_P1     },
        [ 6] = { xi.item.CABALLARIUS_SURCOAT_P1 },
        [ 7] = { xi.item.FALLENS_CUIRASS_P1     },
        [ 8] = { xi.item.ANKUSA_JACKCOAT_P1     },
        [ 9] = { xi.item.BIHU_JUSTAUCORPS_P1    },
        [10] = { xi.item.ARCADIAN_JERKIN_P1     },
        [11] = { xi.item.SAKONJI_DOMARU_P1      },
        [12] = { xi.item.MOCHIZUKI_CHAINMAIL_P1 },
        [13] = { xi.item.PTEROSLAVER_MAIL_P1    },
        [14] = { xi.item.GLYPHIC_DOUBLET_P1     },
        [15] = { xi.item.LUHLAZA_JUBBAH_P1      },
        [16] = { xi.item.LANUN_FRAC_P1          },
        [17] = { xi.item.PITRE_TOBE_P1          },
        [18] = { xi.item.HOROS_CASAQUE_P1       },
        [19] = { xi.item.PEDAGOGY_GOWN_P1       },
        [20] = { xi.item.BAGUA_TUNIC_P1         },
        [21] = { xi.item.FUTHARK_COAT_P1        },
    },

    [14] = -- Deed Token +1: Hands
    {
        [ 0] = { xi.item.AGOGE_MUFFLERS_P1               },
        [ 1] = { xi.item.HESYCHASTS_GLOVES_P1            },
        [ 2] = { xi.item.PIETY_MITTS_P1                  },
        [ 3] = { xi.item.ARCHMAGES_GLOVES_P1             },
        [ 4] = { xi.item.VITIATION_GLOVES_P1             },
        [ 5] = { xi.item.PLUNDERERS_ARMLETS_P1           },
        [ 6] = { xi.item.CABALLARIUS_GAUNTLETS_P1        },
        [ 7] = { xi.item.FALLENS_FINGER_GAUNTLETS_P1     },
        [ 8] = { xi.item.ANKUSA_GLOVES_P1                },
        [ 9] = { xi.item.BIHU_CUFFS_P1                   },
        [10] = { xi.item.ARCADIAN_BRACERS_P1             },
        [11] = { xi.item.SAKONJI_KOTE_P1                 },
        [12] = { xi.item.MOCHIZUKI_TEKKO_P1              },
        [13] = { xi.item.PTEROSLAVER_FINGER_GAUNTLETS_P1 },
        [14] = { xi.item.GLYPHIC_BRACERS_P1              },
        [15] = { xi.item.LUHLAZA_BAZUBANDS_P1            },
        [16] = { xi.item.LANUN_GANTS_P1                  },
        [17] = { xi.item.PITRE_DASTANAS_P1               },
        [18] = { xi.item.HOROS_BANGLES_P1                },
        [19] = { xi.item.PEDAGOGY_BRACERS_P1             },
        [20] = { xi.item.BAGUA_MITAINES_P1               },
        [21] = { xi.item.FUTHARK_MITONS_P1               },
    },

    [15] = -- Deed Token +1: Legs
    {
        [ 0] = { xi.item.AGOGE_CUISSES_P1        },
        [ 1] = { xi.item.HESYCHASTS_HOSE_P1      },
        [ 2] = { xi.item.PIETY_PANTALOONS_P1     },
        [ 3] = { xi.item.ARCHMAGES_TONBAN_P1     },
        [ 4] = { xi.item.VITIATION_TIGHTS_P1     },
        [ 5] = { xi.item.PLUNDERERS_CULOTTES_P1  },
        [ 6] = { xi.item.CABALLARIUS_BREECHES_P1 },
        [ 7] = { xi.item.FALLENS_FLANCHARD_P1    },
        [ 8] = { xi.item.ANKUSA_TROUSERS_P1      },
        [ 9] = { xi.item.BIHU_CANNIONS_P1        },
        [10] = { xi.item.ARCADIAN_BRACCAE_P1     },
        [11] = { xi.item.SAKONJI_HAIDATE_P1      },
        [12] = { xi.item.MOCHIZUKI_HAKAMA_P1     },
        [13] = { xi.item.PTEROSLAVER_BRAIS_P1    },
        [14] = { xi.item.GLYPHIC_SPATS_P1        },
        [15] = { xi.item.LUHLAZA_SHALWAR_P1      },
        [16] = { xi.item.LANUN_CULOTTES_P1       },
        [17] = { xi.item.PITRE_CHURIDARS_P1      },
        [18] = { xi.item.HOROS_TIGHTS_P1         },
        [19] = { xi.item.PEDAGOGY_PANTS_P1       },
        [20] = { xi.item.BAGUA_PANTS_P1          },
        [21] = { xi.item.FUTHARK_TROUSERS_P1     },
    },

    [16] = -- Deed Token +1: Feet
    {
        [ 0] = { xi.item.AGOGE_CALLIGAE_P1       },
        [ 1] = { xi.item.HESYCHASTS_GAITERS_P1   },
        [ 2] = { xi.item.PIETY_DUCKBILLS_P1      },
        [ 3] = { xi.item.ARCHMAGES_SABOTS_P1     },
        [ 4] = { xi.item.VITIATION_BOOTS_P1      },
        [ 5] = { xi.item.PLUNDERERS_POULAINES_P1 },
        [ 6] = { xi.item.CABALLARIUS_LEGGINGS_P1 },
        [ 7] = { xi.item.FALLENS_SOLLERETS_P1    },
        [ 8] = { xi.item.ANKUSA_GAITERS_P1       },
        [ 9] = { xi.item.BIHU_SLIPPERS_P1        },
        [10] = { xi.item.ARCADIAN_SOCKS_P1       },
        [11] = { xi.item.SAKONJI_SUNE_ATE_P1     },
        [12] = { xi.item.MOCHIZUKI_KYAHAN_P1     },
        [13] = { xi.item.PTEROSLAVER_GREAVES_P1  },
        [14] = { xi.item.GLYPHIC_PIGACHES_P1     },
        [15] = { xi.item.LUHLAZA_CHARUQS_P1      },
        [16] = { xi.item.LANUN_BOTTES_P1         },
        [17] = { xi.item.PITRE_BABOUCHES_P1      },
        [18] = { xi.item.HOROS_TOE_SHOES_P1      },
        [19] = { xi.item.PEDAGOGY_LOAFERS_P1     },
        [20] = { xi.item.BAGUA_SANDALS_P1        },
        [21] = { xi.item.FUTHARK_BOOTS_P1        },
    },

    [17] = -- Deed Token +2: Head
    {
        [ 0] = { xi.item.AGOGE_MASK_P2           },
        [ 1] = { xi.item.HESYCHASTS_CROWN_P2     },
        [ 2] = { xi.item.PIETY_CAP_P2            },
        [ 3] = { xi.item.ARCHMAGES_PETASOS_P2    },
        [ 4] = { xi.item.VITIATION_CHAPEAU_P2    },
        [ 5] = { xi.item.PLUNDERERS_BONNET_P2    },
        [ 6] = { xi.item.CABALLARIUS_CORONET_P2  },
        [ 7] = { xi.item.FALLENS_BURGEONET_P2    },
        [ 8] = { xi.item.ANKUSA_HELM_P2          },
        [ 9] = { xi.item.BIHU_ROUNDLET_P2        },
        [10] = { xi.item.ARCADIAN_BERET_P2       },
        [11] = { xi.item.SAKONJI_KABUTO_P2       },
        [12] = { xi.item.MOCHIZUKI_HATSUBURI_P2  },
        [13] = { xi.item.PTEROSLAVER_ARMET_P2    },
        [14] = { xi.item.GLYPHIC_HORN_P2         },
        [15] = { xi.item.LUHLAZA_KEFFIYEH_P2     },
        [16] = { xi.item.LANUN_TRICORNE_P2       },
        [17] = { xi.item.PITRE_TAJ_P2            },
        [18] = { xi.item.HOROS_TIARA_P2          },
        [19] = { xi.item.PEDAGOGY_MORTARBOARD_P2 },
        [20] = { xi.item.BAGUA_GALERO_P2         },
        [21] = { xi.item.FUTHARK_BANDEAU_P2      },
    },

    [18] = -- Deed Token +2: Chest
    {
        [ 0] = { xi.item.AGOGE_LORICA_P2        },
        [ 1] = { xi.item.HESYCHASTS_CYCLAS_P2   },
        [ 2] = { xi.item.PIETY_BRIAULT_P2       },
        [ 3] = { xi.item.ARCHMAGES_COAT_P2      },
        [ 4] = { xi.item.VITIATION_TABARD_P2    },
        [ 5] = { xi.item.PLUNDERERS_VEST_P2     },
        [ 6] = { xi.item.CABALLARIUS_SURCOAT_P2 },
        [ 7] = { xi.item.FALLENS_CUIRASS_P2     },
        [ 8] = { xi.item.ANKUSA_JACKCOAT_P2     },
        [ 9] = { xi.item.BIHU_JUSTAUCORPS_P2    },
        [10] = { xi.item.ARCADIAN_JERKIN_P2     },
        [11] = { xi.item.SAKONJI_DOMARU_P2      },
        [12] = { xi.item.MOCHIZUKI_CHAINMAIL_P2 },
        [13] = { xi.item.PTEROSLAVER_MAIL_P2    },
        [14] = { xi.item.GLYPHIC_DOUBLET_P2     },
        [15] = { xi.item.LUHLAZA_JUBBAH_P2      },
        [16] = { xi.item.LANUN_FRAC_P2          },
        [17] = { xi.item.PITRE_TOBE_P2          },
        [18] = { xi.item.HOROS_CASAQUE_P2       },
        [19] = { xi.item.PEDAGOGY_GOWN_P2       },
        [20] = { xi.item.BAGUA_TUNIC_P2         },
        [21] = { xi.item.FUTHARK_COAT_P2        },
    },

    [19] = -- Deed Token +2: Hands
    {
        [ 0] = { xi.item.AGOGE_MUFFLERS_P2               },
        [ 1] = { xi.item.HESYCHASTS_GLOVES_P2            },
        [ 2] = { xi.item.PIETY_MITTS_P2                  },
        [ 3] = { xi.item.ARCHMAGES_GLOVES_P2             },
        [ 4] = { xi.item.VITIATION_GLOVES_P2             },
        [ 5] = { xi.item.PLUNDERERS_ARMLETS_P2           },
        [ 6] = { xi.item.CABALLARIUS_GAUNTLETS_P2        },
        [ 7] = { xi.item.FALLENS_FINGER_GAUNTLETS_P2     },
        [ 8] = { xi.item.ANKUSA_GLOVES_P2                },
        [ 9] = { xi.item.BIHU_CUFFS_P2                   },
        [10] = { xi.item.ARCADIAN_BRACERS_P2             },
        [11] = { xi.item.SAKONJI_KOTE_P2                 },
        [12] = { xi.item.MOCHIZUKI_TEKKO_P2              },
        [13] = { xi.item.PTEROSLAVER_FINGER_GAUNTLETS_P2 },
        [14] = { xi.item.GLYPHIC_BRACERS_P2              },
        [15] = { xi.item.LUHLAZA_BAZUBANDS_P2            },
        [16] = { xi.item.LANUN_GANTS_P2                  },
        [17] = { xi.item.PITRE_DASTANAS_P2               },
        [18] = { xi.item.HOROS_BANGLES_P2                },
        [19] = { xi.item.PEDAGOGY_BRACERS_P2             },
        [20] = { xi.item.BAGUA_MITAINES_P2               },
        [21] = { xi.item.FUTHARK_MITONS_P2               },
    },

    [20] = -- Deed Token +2: Legs
    {
        [ 0] = { xi.item.AGOGE_CUISSES_P2        },
        [ 1] = { xi.item.HESYCHASTS_HOSE_P2      },
        [ 2] = { xi.item.PIETY_PANTALOONS_P2     },
        [ 3] = { xi.item.ARCHMAGES_TONBAN_P2     },
        [ 4] = { xi.item.VITIATION_TIGHTS_P2     },
        [ 5] = { xi.item.PLUNDERERS_CULOTTES_P2  },
        [ 6] = { xi.item.CABALLARIUS_BREECHES_P2 },
        [ 7] = { xi.item.FALLENS_FLANCHARD_P2    },
        [ 8] = { xi.item.ANKUSA_TROUSERS_P2      },
        [ 9] = { xi.item.BIHU_CANNIONS_P2        },
        [10] = { xi.item.ARCADIAN_BRACCAE_P2     },
        [11] = { xi.item.SAKONJI_HAIDATE_P2      },
        [12] = { xi.item.MOCHIZUKI_HAKAMA_P2     },
        [13] = { xi.item.PTEROSLAVER_BRAIS_P2    },
        [14] = { xi.item.GLYPHIC_SPATS_P2        },
        [15] = { xi.item.LUHLAZA_SHALWAR_P2      },
        [16] = { xi.item.LANUN_CULOTTES_P2       },
        [17] = { xi.item.PITRE_CHURIDARS_P2      },
        [18] = { xi.item.HOROS_TIGHTS_P2         },
        [19] = { xi.item.PEDAGOGY_PANTS_P2       },
        [20] = { xi.item.BAGUA_PANTS_P2          },
        [21] = { xi.item.FUTHARK_TROUSERS_P2     },
    },

    [21] = -- Deed Token +2: Feet
    {
        [ 0] = { xi.item.AGOGE_CALLIGAE_P2       },
        [ 1] = { xi.item.HESYCHASTS_GAITERS_P2   },
        [ 2] = { xi.item.PIETY_DUCKBILLS_P2      },
        [ 3] = { xi.item.ARCHMAGES_SABOTS_P2     },
        [ 4] = { xi.item.VITIATION_BOOTS_P2      },
        [ 5] = { xi.item.PLUNDERERS_POULAINES_P2 },
        [ 6] = { xi.item.CABALLARIUS_LEGGINGS_P2 },
        [ 7] = { xi.item.FALLENS_SOLLERETS_P2    },
        [ 8] = { xi.item.ANKUSA_GAITERS_P2       },
        [ 9] = { xi.item.BIHU_SLIPPERS_P2        },
        [10] = { xi.item.ARCADIAN_SOCKS_P2       },
        [11] = { xi.item.SAKONJI_SUNE_ATE_P2     },
        [12] = { xi.item.MOCHIZUKI_KYAHAN_P2     },
        [13] = { xi.item.PTEROSLAVER_GREAVES_P2  },
        [14] = { xi.item.GLYPHIC_PIGACHES_P2     },
        [15] = { xi.item.LUHLAZA_CHARUQS_P2      },
        [16] = { xi.item.LANUN_BOTTES_P2         },
        [17] = { xi.item.PITRE_BABOUCHES_P2      },
        [18] = { xi.item.HOROS_TOE_SHOES_P2      },
        [19] = { xi.item.PEDAGOGY_LOAFERS_P2     },
        [20] = { xi.item.BAGUA_SANDALS_P2        },
        [21] = { xi.item.FUTHARK_BOOTS_P2        },
    },
}

local function getStoredVoucherMask(player)
    local voucherMask = 0

    for keyItemIndex = 1, #voucherKeyItems do
        if player:hasKeyItem(voucherKeyItems[keyItemIndex]) then
            voucherMask = utils.mask.setBit(voucherMask, keyItemIndex - 1, true)
        end
    end

    return voucherMask
end

local function updateValidatorEvent(player)
    local claimedRewards = player:getClaimedDeedMask()
    local storedVouchers = getStoredVoucherMask(player)
    local numDeeds       = player:getCurrency('deeds')
    local showOrHide     = bit.band(claimedRewards[1], 0x1)

    player:updateEvent(
        numDeeds,
        claimedRewards[1],
        claimedRewards[2],
        claimedRewards[3],
        claimedRewards[4],
        claimedRewards[5],
        storedVouchers,
        showOrHide
    )
end

local function hasItemInSet(player, setTable)
    for _, itemId in ipairs(setTable) do
        if player:hasItem(itemId) then
            return true
        end
    end

    return false
end

xi.deeds.validatorOnTrigger = function(player, npc)
    local zoneId         = player:getZoneID()
    local numDeeds       = player:getCurrency('deeds')
    local claimedRewards = player:getClaimedDeedMask()
    local storedVouchers = getStoredVoucherMask(player)
    local showOrHide     = bit.band(claimedRewards[1], 0x1)

    player:startEvent(validatorNpcEvents[zoneId],
        numDeeds,
        claimedRewards[1],
        claimedRewards[2],
        claimedRewards[3],
        claimedRewards[4],
        claimedRewards[5],
        storedVouchers,
        showOrHide
    )
end

xi.deeds.validatorOnEventUpdate = function(player, csid, option, npc)
    -- TODO: Determine what happens if inventory is full, or rare/ex item cannot
    -- be obtained.
    local updateAction = bit.rshift(option, 16)
    local updateOption = bit.band(option, 0xFFFF)
    print(option)

    if
        (updateAction == 1 or updateAction == 3) and
        validatorRewards[updateOption]
    then
        local bitLocation    = updateOption
        local claimedRewards = player:getClaimedDeedMask()
        local numDeeds       = player:getCurrency('deeds')
        local totalCost      = updateOption * 10

        -- NOTE: Resettable rewards (970+) are handled in the same table; however, the stored
        -- data is offset by one bit in the fourth parameter.  This block handles the conversion
        -- for the following condition.
        if updateAction == 3 then
            updateOption = updateOption > 0 and updateOption + 96 or 0
            bitLocation  = updateOption + 1
            totalCost    = 480 * bit.rshift(claimedRewards[5], 18) + updateOption * 10
        end

        if numDeeds >= totalCost then
            if validatorRewards[updateOption]['keyItemId'] then
                npcUtil.giveKeyItem(player, validatorRewards[updateOption]['keyItemId'])
                player:setClaimedDeed(bitLocation)
            elseif npcUtil.giveItem(player, { { validatorRewards[updateOption]['itemId'], validatorRewards[updateOption]['qty'] } }) then
                player:setClaimedDeed(bitLocation)
            end

            -- Only update event if the player can purchase the item.
            updateValidatorEvent(player)
        end
    elseif updateAction == 2 then
        local keyItemIndex = bit.rshift(updateOption, 8)
        local selectedSet  = bit.band(updateOption, 0xFF)
        local rewardTable  = {}

        -- NOTE: Lua tables are passed by reference on assignment, and need to ensure
        -- that we're not accidentally overwriting data when determining what to use.
        if voucherData[keyItemIndex][selectedSet].genderSpecific then
            rewardTable = voucherData[keyItemIndex][selectedSet][player:getGender()]
        else
            rewardTable = voucherData[keyItemIndex][selectedSet]
        end

        -- NOTE: Do not attempt to give any of the items if the player cannot obtain them
        -- all.  All of the rewarded items are R/EX, so it is safe to check count and hasItem.
        if
            player:getFreeSlotsCount() >= #rewardTable and
            not hasItemInSet(player, rewardTable)
        then
            player:delKeyItem(voucherKeyItems[keyItemIndex + 1])

            for _, itemId in ipairs(rewardTable) do
                npcUtil.giveItem(player, itemId)
            end
        else
            local ID = zones[player:getZoneID()]

            player:messageSpecial(ID.text.CANNOT_OBTAIN_THE_ITEM)
        end

        updateValidatorEvent(player)
    elseif updateAction == 4 and updateOption == 0 then
        player:resetClaimedDeeds()
        updateValidatorEvent(player)
    elseif updateAction == 10 and updateOption == 0 then
        player:toggleReceivedDeedRewards()
        updateValidatorEvent(player)
    end
end

xi.deeds.validatorOnEventFinish = function(player, csid, option, npc)
end
