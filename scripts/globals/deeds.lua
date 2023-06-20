-----------------------------------
-- Deeds of Heroism (A.M.A.N. Validator)
-----------------------------------
-- Bastok Markets      : !pos -338.18 -10 -180.19 235
-- Southern San d'Oria : !pos -83.07 1 -55.58 230
-- Windurst Woods      : !pos 89.9 -4.2 -47.63 241
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/utils')
require('scripts/globals/zone')
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
    [  1] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  7 },
    [  2] = { itemId    = xi.items.MOGGIEBAG,                      qty =  1 },
    [  3] = { itemId    = xi.items.ENDORSEMENT_RING,               qty =  1 },
    [  4] = { itemId    = xi.items.THEMIS_ORB,                     qty =  1 },

    [  5] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty = 14 },
    [  6] = { itemId    = xi.items.MOOGLES_LARGESSE,               qty =  1 },
    [  7] = { keyItemId = xi.ki.DEED_VOUCHER                                },
    [  8] = { itemId    = xi.items.PHOBOS_ORB,                     qty =  1 },

    [  9] = { itemId    = xi.items.MOGRATUITY,                     qty =  1 },
    [ 10] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 11] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_FEET                    },
    [ 12] = { itemId    = xi.items.DEIMOS_ORB,                     qty =  1 },

    [ 13] = { itemId    = xi.items.POUCH_OF_MOOGLE_MOOLAH,         qty =  1 },
    [ 14] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 15] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_HANDS                   },
    [ 16] = { itemId    = xi.items.ZELOS_ORB,                      qty =  1 },

    [ 17] = { itemId    = xi.items.MOG_KUPON_W_PULSE,              qty =  1 },
    [ 18] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 19] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_HEAD                    },
    [ 20] = { itemId    = xi.items.BIA_ORB,                        qty =  1 },

    [ 21] = { itemId    = xi.items.MOGGIE_GOODIE_BAG,              qty =  1 },
    [ 22] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 23] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_LEGS                    },
    [ 24] = { itemId    = xi.items.MICROCOSMIC_ORB,                qty =  1 },

    [ 25] = { itemId    = xi.items.GOBBIE_GOODIE_BAG,              qty =  1 },
    [ 26] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 27] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_1_CHEST                   },
    [ 28] = { itemId    = xi.items.MACROCOSMIC_ORB,                qty =  1 },

    [ 29] = { itemId    = xi.items.AMBUSCADE_VOUCHER_WEAPON,       qty =  1 },
    [ 30] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 31] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_FEET                    },
    [ 32] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [ 33] = { itemId    = xi.items.WYRMKING_MASQUE,                qty =  1 },
    [ 34] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 35] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_HANDS                   },
    [ 36] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [ 37] = { itemId    = xi.items.WYRMKING_SUIT,                  qty =  1 },
    [ 38] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 39] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_HEAD                    },
    [ 40] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [ 41] = { itemId    = xi.items.AKITU_SHIRT,                    qty =  1 },
    [ 42] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 43] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_LEGS                    },
    [ 44] = { itemId    = xi.items.VENUS_ORB,                      qty =  1 },

    [ 45] = { itemId    = xi.items.CRUSTACEAN_SHIRT,               qty =  1 },
    [ 46] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 47] = { keyItemId = xi.ki.DEED_VOUCHER_PLUS_2_CHEST                   },
    [ 48] = { itemId    = xi.items.CIPHER_OF_MONBERAUXS_ALTER_EGO, qty =  1 },

    [ 49] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty = 10 },
    [ 50] = { itemId    = xi.items.MAATS_CONCOCTION,               qty =  1 },
    [ 51] = { itemId    = xi.items.DIAL_KEY_FO,                    qty =  5 },
    [ 52] = { itemId    = xi.items.THEMIS_ORB,                     qty =  1 },

    [ 53] = { itemId    = xi.items.ABDHALJS_SEAL,                  qty =  5 },
    [ 54] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 55] = { keyItemId = xi.ki.DEED_TOKEN                                  },
    [ 56] = { itemId    = xi.items.PHOBOS_ORB,                     qty =  1 },

    [ 57] = { itemId    = xi.items.DECANTER_INGRID,                qty =  1 },
    [ 58] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 59] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_FEET                      },
    [ 60] = { itemId    = xi.items.DEIMOS_ORB,                     qty =  1 },

    [ 61] = { itemId    = xi.items.DECANTER_DARRCUILN,             qty =  1 },
    [ 62] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 63] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_HANDS                     },
    [ 64] = { itemId    = xi.items.ZELOS_ORB,                      qty =  1 },

    [ 65] = { itemId    = xi.items.DECANTER_ARCIELA,               qty =  1 },
    [ 66] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [ 67] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_HEAD                      },
    [ 68] = { itemId    = xi.items.BIA_ORB,                        qty =  1 },

    [ 69] = { itemId    = xi.items.DIAL_KEY_AB,                    qty =  5 },
    [ 70] = { itemId    = xi.items.MICROCOSMIC_ORB,                qty =  1 },
    [ 71] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_LEGS                      },
    [ 72] = { keyItemId = xi.ki.PRIMER_ON_MARTIAL_TECHNIQUES                },

    [ 73] = { itemId    = xi.items.DECANTER_MORIMAR,               qty =  1 },
    [ 74] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 75] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_1_CHEST                     },
    [ 76] = { itemId    = xi.items.MACROCOSMIC_ORB,                qty =  1 },

    [ 77] = { itemId    = xi.items.DECANTER_ROSULATIA,             qty =  1 },
    [ 78] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 79] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_FEET                      },
    [ 80] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [ 81] = { itemId    = xi.items.DECANTER_TEODOR,                qty =  1 },
    [ 82] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 83] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_HANDS                     },
    [ 84] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [ 85] = { itemId    = xi.items.DECANTER_SAJJAKA,               qty =  1 },
    [ 86] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 87] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_HEAD                      },
    [ 88] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [ 89] = { itemId    = xi.items.DECANTER_ARCIELA_II,            qty =  1 },
    [ 90] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 91] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_LEGS                      },
    [ 92] = { itemId    = xi.items.VENUS_ORB,                      qty =  1 },

    [ 93] = { itemId    = xi.items.DECANTER_AUGUST,                qty =  1 },
    [ 94] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [ 95] = { keyItemId = xi.ki.DEED_TOKEN_PLUS_2_CHEST                     },
    [ 96] = { keyItemId = xi.ki.TREATISE_ON_MARTIAL_TECHNIQUES              },

    [ 97] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [ 98] = { itemId    = xi.items.ABDHALJS_SEAL,                  qty =  1 },
    [ 99] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [100] = { itemId    = xi.items.SUPER_RERAISER_TANK,            qty =  1 },

    [101] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [102] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [103] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [104] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [105] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [106] = { itemId    = xi.items.ABDHALJS_SEAL,                  qty =  3 },
    [107] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [108] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [109] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [110] = { itemId    = xi.items.DIAL_KEY_FO,                    qty =  5 },
    [111] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [112] = { itemId    = xi.items.VENUS_ORB,                      qty =  1 },

    [113] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  1 },
    [114] = { itemId    = xi.items.ABDHALJS_SEAL,                  qty =  3 },
    [115] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [116] = { itemId    = xi.items.ABRIDGED_FIENDISH_COMPENDIUM,   qty =  1 },

    [117] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [118] = { itemId    = xi.items.SPECIAL_GOBBIEDIAL_KEY,         qty =  5 },
    [119] = { itemId    = xi.items.GREEN_MOG_PELL,                 qty =  1 },
    [120] = { itemId    = xi.items.MAATS_CONCOCTION,               qty =  1 },

    [121] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [122] = { itemId    = xi.items.ABDHALJS_SEAL,                  qty =  3 },
    [123] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [124] = { itemId    = xi.items.MOG_KUPON_W_PULSE,              qty =  1 },

    [125] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [126] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [127] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [128] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [129] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [130] = { itemId    = xi.items.ABDHALJS_SEAL,                  qty =  3 },
    [131] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [132] = { itemId    = xi.items.MARS_ORB,                       qty =  1 },

    [133] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [134] = { itemId    = xi.items.DIAL_KEY_FO,                    qty =  5 },
    [135] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [136] = { itemId    = xi.items.VENUS_ORB,                      qty =  1 },

    [137] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [138] = { itemId    = xi.items.ABDHALJS_SEAL,                  qty =  3 },
    [139] = { itemId    = xi.items.MAATS_MIX,                      qty =  1 },
    [140] = { itemId    = xi.items.PANDEMONIUM_KEY,                qty =  1 },

    [141] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,            qty =  3 },
    [142] = { itemId    = xi.items.DIAL_KEY_ANV,                   qty =  5 },
    [143] = { itemId    = xi.items.GREEN_MOG_PELL,                 qty =  1 },
    [144] = { itemId    = xi.items.MAATS_CONCOCTION,               qty =  1 },
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
            xi.items.PUMMELERS_MASK,
            xi.items.PUMMELERS_LORICA,
            xi.items.PUMMELERS_MUFFLERS,
            xi.items.PUMMELERS_CUISSES,
            xi.items.PUMMELERS_CALLIGAE,
        },

        [1] =
        {
            xi.items.ANCHORITES_CROWN,
            xi.items.ANCHORITES_CYCLAS,
            xi.items.ANCHORITES_GLOVES,
            xi.items.ANCHORITES_HOSE,
            xi.items.ANCHORITES_GAITERS,
        },

        [2] =
        {
            xi.items.THEOPHANY_CAP,
            xi.items.THEOPHANY_BRIAULT,
            xi.items.THEOPHANY_MITTS,
            xi.items.THEOPHANY_PANTALOONS,
            xi.items.THEOPHANY_DUCKBILLS,
        },

        [3] =
        {
            xi.items.SPAEKONAS_PETASOS,
            xi.items.SPAEKONAS_COAT,
            xi.items.SPAEKONAS_GLOVES,
            xi.items.SPAEKONAS_TONBAN,
            xi.items.SPAEKONAS_SABOTS,
        },

        [4] =
        {
            xi.items.ATROPHY_CHAPEAU,
            xi.items.ATROPHY_TABARD,
            xi.items.ATROPHY_GLOVES,
            xi.items.ATROPHY_TIGHTS,
            xi.items.ATROPHY_BOOTS,
        },

        [5] =
        {
            xi.items.PILLAGERS_BONNET,
            xi.items.PILLAGERS_VEST,
            xi.items.PILLAGERS_ARMLETS,
            xi.items.PILLAGERS_CULOTTES,
            xi.items.PILLAGERS_POULAINES,
        },

        [6] =
        {
            xi.items.REVERENCE_CORONET,
            xi.items.REVERENCE_SURCOAT,
            xi.items.REVERENCE_GAUNTLETS,
            xi.items.REVERENCE_BREECHES,
            xi.items.REVERENCE_LEGGINGS,
        },

        [7] =
        {
            xi.items.IGNOMINY_BURGEONET,
            xi.items.IGNOMINY_CUIRASS,
            xi.items.IGNOMINY_GAUNTLETS,
            xi.items.IGNOMINY_FLANCHARD,
            xi.items.IGNOMINY_SOLLERETS,
        },

        [8] =
        {
            xi.items.TOTEMIC_HELM,
            xi.items.TOTEMIC_JACKCOAT,
            xi.items.TOTEMIC_GLOVES,
            xi.items.TOTEMIC_TROUSERS,
            xi.items.TOTEMIC_GAITERS,
        },

        [9] =
        {
            xi.items.BRIOSO_ROUNDLET,
            xi.items.BRIOSO_JUSTAUCORPS,
            xi.items.BRIOSO_CUFFS,
            xi.items.BRIOSO_CANNIONS,
            xi.items.BRIOSO_SLIPPERS,
        },

        [10] =
        {
            xi.items.ORION_BERET,
            xi.items.ORION_JERKIN,
            xi.items.ORION_BRACERS,
            xi.items.ORION_BRACCAE,
            xi.items.ORION_SOCKS,
        },

        [11] =
        {
            xi.items.WAKIDO_KABUTO,
            xi.items.WAKIDO_DOMARU,
            xi.items.WAKIDO_KOTE,
            xi.items.WAKIDO_HAIDATE,
            xi.items.WAKIDO_SUNE_ATE,
        },

        [12] =
        {
            xi.items.HACHIYA_HATSUBURI,
            xi.items.HACHIYA_CHAINMAIL,
            xi.items.HACHIYA_TEKKO,
            xi.items.HACHIYA_HAKAMA,
            xi.items.HACHIYA_KYAHAN,
        },

        [13] =
        {
            xi.items.VISHAP_ARMET,
            xi.items.VISHAP_MAIL,
            xi.items.VISHAP_FINGER_GAUNTLETS,
            xi.items.VISHAP_BRAIS,
            xi.items.VISHAP_GREAVES,
        },

        [14] =
        {
            xi.items.CONVOKERS_HORN,
            xi.items.CONVOKERS_DOUBLET,
            xi.items.CONVOKERS_BRACERS,
            xi.items.CONVOKERS_SPATS,
            xi.items.CONVOKERS_PIGACHES,
        },

        [15] =
        {
            xi.items.ASSIMILATORS_KEFFIYEH,
            xi.items.ASSIMILATORS_JUBBAH,
            xi.items.ASSIMILATORS_BAZUBANDS,
            xi.items.ASSIMILATORS_SHALWAR,
            xi.items.ASSIMILATORS_CHARUQS,
        },

        [16] =
        {
            xi.items.LAKSAMANAS_TRICORNE,
            xi.items.LAKSAMANAS_FRAC,
            xi.items.LAKSAMANAS_GANTS,
            xi.items.LAKSAMANAS_TREWS,
            xi.items.LAKSAMANAS_BOTTES,
        },

        [17] =
        {
            xi.items.FOIRE_TAJ,
            xi.items.FOIRE_TOBE,
            xi.items.FOIRE_DASTANAS,
            xi.items.FOIRE_CHURIDARS,
            xi.items.FOIRE_BABOUCHES,
        },

        [18] =
        {
            genderSpecific = true,

            [0] =
            {
                xi.items.MAXIXI_TIARA_F,
                xi.items.MAXIXI_CASAQUE_F,
                xi.items.MAXIXI_BANGLES_F,
                xi.items.MAXIXI_TIGHTS_F,
                xi.items.MAXIXI_TOE_SHOES_F,
            },

            [1] =
            {
                xi.items.MAXIXI_TIARA_M,
                xi.items.MAXIXI_CASAQUE_M,
                xi.items.MAXIXI_BANGLES_M,
                xi.items.MAXIXI_TIGHTS_M,
                xi.items.MAXIXI_TOE_SHOES_M,
            },
        },

        [19] =
        {
            xi.items.ACADEMICS_MORTARBOARD,
            xi.items.ACADEMICS_GOWN,
            xi.items.ACADEMICS_BRACERS,
            xi.items.ACADEMICS_PANTS,
            xi.items.ACADEMICS_LOAFERS,
        },

        [20] =
        {
            xi.items.GEOMANCY_GALERO,
            xi.items.GEOMANCY_TUNIC,
            xi.items.GEOMANCY_MITAINES,
            xi.items.GEOMANCY_PANTS,
            xi.items.GEOMANCY_SANDALS,
        },

        [21] =
        {
            xi.items.RUNEIST_BANDEAU,
            xi.items.RUNEIST_COAT,
            xi.items.RUNEIST_MITONS,
            xi.items.RUNEIST_TROUSERS,
            xi.items.RUNEIST_BOTTES,
        },
    },

    [1] = -- Deed Voucher +1: Head
    {
        [ 0] = { xi.items.PUMMELERS_MASK_P1        },
        [ 1] = { xi.items.ANCHORITES_CROWN_P1      },
        [ 2] = { xi.items.THEOPHANY_CAP_P1         },
        [ 3] = { xi.items.SPAEKONAS_PETASOS_P1     },
        [ 4] = { xi.items.ATROPHY_CHAPEAU_P1       },
        [ 5] = { xi.items.PILLAGERS_BONNET_P1      },
        [ 6] = { xi.items.REVERENCE_CORONET_P1     },
        [ 7] = { xi.items.IGNOMINY_BURGEONET_P1    },
        [ 8] = { xi.items.TOTEMIC_HELM_P1          },
        [ 9] = { xi.items.BRIOSO_ROUNDLET_P1       },
        [10] = { xi.items.ORION_BERET_P1           },
        [11] = { xi.items.WAKIDO_KABUTO_P1         },
        [12] = { xi.items.HACHIYA_HATSUBURI_P1     },
        [13] = { xi.items.VISHAP_ARMET_P1          },
        [14] = { xi.items.CONVOKERS_HORN_P1        },
        [15] = { xi.items.ASSIMILATORS_KEFFIYEH_P1 },
        [16] = { xi.items.LAKSAMANAS_TRICORNE_P1   },
        [17] = { xi.items.FOIRE_TAJ_P1             },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_TIARA_F_P1 },
            [1] = { xi.items.MAXIXI_TIARA_M_P1 },
        },

        [19] = { xi.items.ACADEMICS_MORTARBOARD_P1 },
        [20] = { xi.items.GEOMANCY_GALERO_P1       },
        [21] = { xi.items.RUNEIST_BANDEAU_P1       },
    },

    [2] = -- Deed Voucher +1: Chest
    {
        [ 0] = { xi.items.PUMMELERS_LORICA_P1    },
        [ 1] = { xi.items.ANCHORITES_CYCLAS_P1   },
        [ 2] = { xi.items.THEOPHANY_BRIAULT_P1   },
        [ 3] = { xi.items.SPAEKONAS_COAT_P1      },
        [ 4] = { xi.items.ATROPHY_TABARD_P1      },
        [ 5] = { xi.items.PILLAGERS_VEST_P1      },
        [ 6] = { xi.items.REVERENCE_SURCOAT_P1   },
        [ 7] = { xi.items.IGNOMINY_CUIRASS_P1    },
        [ 8] = { xi.items.TOTEMIC_JACKCOAT_P1    },
        [ 9] = { xi.items.BRIOSO_JUSTAUCORPS_P1  },
        [10] = { xi.items.ORION_JERKIN_P1        },
        [11] = { xi.items.WAKIDO_DOMARU_P1       },
        [12] = { xi.items.HACHIYA_CHAINMAIL_P1   },
        [13] = { xi.items.VISHAP_MAIL_P1         },
        [14] = { xi.items.CONVOKERS_DOUBLET_P1   },
        [15] = { xi.items.ASSIMILATORS_JUBBAH_P1 },
        [16] = { xi.items.LAKSAMANAS_FRAC_P1     },
        [17] = { xi.items.FOIRE_TOBE_P1          },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_CASAQUE_F_P1 },
            [1] = { xi.items.MAXIXI_CASAQUE_M_P1 },
        },

        [19] = { xi.items.ACADEMICS_GOWN_P1 },
        [20] = { xi.items.GEOMANCY_TUNIC_P1 },
        [21] = { xi.items.RUNEIST_COAT_P1   },
    },

    [3] = -- Deed Voucher +1: Hands
    {
        [ 0] = { xi.items.PUMMELERS_MUFFLERS_P1      },
        [ 1] = { xi.items.ANCHORITES_GLOVES_P1       },
        [ 2] = { xi.items.THEOPHANY_MITTS_P1         },
        [ 3] = { xi.items.SPAEKONAS_GLOVES_P1        },
        [ 4] = { xi.items.ATROPHY_GLOVES_P1          },
        [ 5] = { xi.items.PILLAGERS_ARMLETS_P1       },
        [ 6] = { xi.items.REVERENCE_GAUNTLETS_P1     },
        [ 7] = { xi.items.IGNOMINY_GAUNTLETS_P1      },
        [ 8] = { xi.items.TOTEMIC_GLOVES_P1          },
        [ 9] = { xi.items.BRIOSO_CUFFS_P1            },
        [10] = { xi.items.ORION_BRACERS_P1           },
        [11] = { xi.items.WAKIDO_KOTE_P1             },
        [12] = { xi.items.HACHIYA_TEKKO_P1           },
        [13] = { xi.items.VISHAP_FINGER_GAUNTLETS_P1 },
        [14] = { xi.items.CONVOKERS_BRACERS_P1       },
        [15] = { xi.items.ASSIMILATORS_BAZUBANDS_P1  },
        [16] = { xi.items.LAKSAMANAS_GANTS_P1        },
        [17] = { xi.items.FOIRE_DASTANAS_P1          },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_BANGLES_F_P1 },
            [1] = { xi.items.MAXIXI_BANGLES_M_P1 },
        },

        [19] = { xi.items.ACADEMICS_BRACERS_P1 },
        [20] = { xi.items.GEOMANCY_MITAINES_P1 },
        [21] = { xi.items.RUNEIST_MITONS_P1    },
    },

    [4] = -- Deed Voucher +1: Legs
    {
        [ 0] = { xi.items.PUMMELERS_CUISSES_P1    },
        [ 1] = { xi.items.ANCHORITES_HOSE_P1      },
        [ 2] = { xi.items.THEOPHANY_PANTALOONS_P1 },
        [ 3] = { xi.items.SPAEKONAS_TONBAN_P1     },
        [ 4] = { xi.items.ATROPHY_TIGHTS_P1       },
        [ 5] = { xi.items.PILLAGERS_CULOTTES_P1   },
        [ 6] = { xi.items.REVERENCE_BREECHES_P1   },
        [ 7] = { xi.items.IGNOMINY_FLANCHARD_P1   },
        [ 8] = { xi.items.TOTEMIC_TROUSERS_P1     },
        [ 9] = { xi.items.BRIOSO_CANNIONS_P1      },
        [10] = { xi.items.ORION_BRACCAE_P1        },
        [11] = { xi.items.WAKIDO_HAIDATE_P1       },
        [12] = { xi.items.HACHIYA_HAKAMA_P1       },
        [13] = { xi.items.VISHAP_BRAIS_P1         },
        [14] = { xi.items.CONVOKERS_SPATS_P1      },
        [15] = { xi.items.ASSIMILATORS_SHALWAR_P1 },
        [16] = { xi.items.LAKSAMANAS_TREWS_P1     },
        [17] = { xi.items.FOIRE_CHURIDARS_P1      },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_TIGHTS_F_P1 },
            [1] = { xi.items.MAXIXI_TIGHTS_M_P1 },
        },

        [19] = { xi.items.ACADEMICS_PANTS_P1  },
        [20] = { xi.items.GEOMANCY_PANTS_P1   },
        [21] = { xi.items.RUNEIST_TROUSERS_P1 },
    },

    [5] = -- Deed Voucher +1: Feet
    {
        [ 0] = { xi.items.PUMMELERS_CALLIGAE_P1   },
        [ 1] = { xi.items.ANCHORITES_GAITERS_P1   },
        [ 2] = { xi.items.THEOPHANY_DUCKBILLS_P1  },
        [ 3] = { xi.items.SPAEKONAS_SABOTS_P1     },
        [ 4] = { xi.items.ATROPHY_BOOTS_P1        },
        [ 5] = { xi.items.PILLAGERS_POULAINES_P1  },
        [ 6] = { xi.items.REVERENCE_LEGGINGS_P1   },
        [ 7] = { xi.items.IGNOMINY_SOLLERETS_P1   },
        [ 8] = { xi.items.TOTEMIC_GAITERS_P1      },
        [ 9] = { xi.items.BRIOSO_SLIPPERS_P1      },
        [10] = { xi.items.ORION_SOCKS_P1          },
        [11] = { xi.items.WAKIDO_SUNE_ATE_P1      },
        [12] = { xi.items.HACHIYA_KYAHAN_P1       },
        [13] = { xi.items.VISHAP_GREAVES_P1       },
        [14] = { xi.items.CONVOKERS_PIGACHES_P1   },
        [15] = { xi.items.ASSIMILATORS_CHARUQS_P1 },
        [16] = { xi.items.LAKSAMANAS_BOTTES_P1    },
        [17] = { xi.items.FOIRE_BABOUCHES_P1      },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_TOE_SHOES_F_P1 },
            [1] = { xi.items.MAXIXI_TOE_SHOES_M_P1 },
        },

        [19] = { xi.items.ACADEMICS_LOAFERS_P1 },
        [20] = { xi.items.GEOMANCY_SANDALS_P1  },
        [21] = { xi.items.RUNEIST_BOTTES_P1    },
    },

    [6] = -- Deed Voucher +2: Head
    {
        [ 0] = { xi.items.PUMMELERS_MASK_P2        },
        [ 1] = { xi.items.ANCHORITES_CROWN_P2      },
        [ 2] = { xi.items.THEOPHANY_CAP_P2         },
        [ 3] = { xi.items.SPAEKONAS_PETASOS_P2     },
        [ 4] = { xi.items.ATROPHY_CHAPEAU_P2       },
        [ 5] = { xi.items.PILLAGERS_BONNET_P2      },
        [ 6] = { xi.items.REVERENCE_CORONET_P2     },
        [ 7] = { xi.items.IGNOMINY_BURGEONET_P2    },
        [ 8] = { xi.items.TOTEMIC_HELM_P2          },
        [ 9] = { xi.items.BRIOSO_ROUNDLET_P2       },
        [10] = { xi.items.ORION_BERET_P2           },
        [11] = { xi.items.WAKIDO_KABUTO_P2         },
        [12] = { xi.items.HACHIYA_HATSUBURI_P2     },
        [13] = { xi.items.VISHAP_ARMET_P2          },
        [14] = { xi.items.CONVOKERS_HORN_P2        },
        [15] = { xi.items.ASSIMILATORS_KEFFIYEH_P2 },
        [16] = { xi.items.LAKSAMANAS_TRICORNE_P2   },
        [17] = { xi.items.FOIRE_TAJ_P2             },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_TIARA_F_P2 },
            [1] = { xi.items.MAXIXI_TIARA_M_P2 },
        },

        [19] = { xi.items.ACADEMICS_MORTARBOARD_P2 },
        [20] = { xi.items.GEOMANCY_GALERO_P2       },
        [21] = { xi.items.RUNEIST_BANDEAU_P2       },
    },

    [7] = -- Deed Voucher +2: Chest
    {
        [ 0] = { xi.items.PUMMELERS_LORICA_P2    },
        [ 1] = { xi.items.ANCHORITES_CYCLAS_P2   },
        [ 2] = { xi.items.THEOPHANY_BRIAULT_P2   },
        [ 3] = { xi.items.SPAEKONAS_COAT_P2      },
        [ 4] = { xi.items.ATROPHY_TABARD_P2      },
        [ 5] = { xi.items.PILLAGERS_VEST_P2      },
        [ 6] = { xi.items.REVERENCE_SURCOAT_P2   },
        [ 7] = { xi.items.IGNOMINY_CUIRASS_P2    },
        [ 8] = { xi.items.TOTEMIC_JACKCOAT_P2    },
        [ 9] = { xi.items.BRIOSO_JUSTAUCORPS_P2  },
        [10] = { xi.items.ORION_JERKIN_P2        },
        [11] = { xi.items.WAKIDO_DOMARU_P2       },
        [12] = { xi.items.HACHIYA_CHAINMAIL_P2   },
        [13] = { xi.items.VISHAP_MAIL_P2         },
        [14] = { xi.items.CONVOKERS_DOUBLET_P2   },
        [15] = { xi.items.ASSIMILATORS_JUBBAH_P2 },
        [16] = { xi.items.LAKSAMANAS_FRAC_P2     },
        [17] = { xi.items.FOIRE_TOBE_P2          },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_CASAQUE_F_P2 },
            [1] = { xi.items.MAXIXI_CASAQUE_M_P2 },
        },

        [19] = { xi.items.ACADEMICS_GOWN_P2 },
        [20] = { xi.items.GEOMANCY_TUNIC_P2 },
        [21] = { xi.items.RUNEIST_COAT_P2   },
    },

    [8] = -- Deed Voucher +2: Hands
    {
        [ 0] = { xi.items.PUMMELERS_MUFFLERS_P2      },
        [ 1] = { xi.items.ANCHORITES_GLOVES_P2       },
        [ 2] = { xi.items.THEOPHANY_MITTS_P2         },
        [ 3] = { xi.items.SPAEKONAS_GLOVES_P2        },
        [ 4] = { xi.items.ATROPHY_GLOVES_P2          },
        [ 5] = { xi.items.PILLAGERS_ARMLETS_P2       },
        [ 6] = { xi.items.REVERENCE_GAUNTLETS_P2     },
        [ 7] = { xi.items.IGNOMINY_GAUNTLETS_P2      },
        [ 8] = { xi.items.TOTEMIC_GLOVES_P2          },
        [ 9] = { xi.items.BRIOSO_CUFFS_P2            },
        [10] = { xi.items.ORION_BRACERS_P2           },
        [11] = { xi.items.WAKIDO_KOTE_P2             },
        [12] = { xi.items.HACHIYA_TEKKO_P2           },
        [13] = { xi.items.VISHAP_FINGER_GAUNTLETS_P2 },
        [14] = { xi.items.CONVOKERS_BRACERS_P2       },
        [15] = { xi.items.ASSIMILATORS_BAZUBANDS_P2  },
        [16] = { xi.items.LAKSAMANAS_GANTS_P2        },
        [17] = { xi.items.FOIRE_DASTANAS_P2          },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_BANGLES_F_P2 },
            [1] = { xi.items.MAXIXI_BANGLES_M_P2 },
        },

        [19] = { xi.items.ACADEMICS_BRACERS_P2 },
        [20] = { xi.items.GEOMANCY_MITAINES_P2 },
        [21] = { xi.items.RUNEIST_MITONS_P2    },
    },

    [9] = -- Deed Voucher +2: Legs
    {
        [ 0] = { xi.items.PUMMELERS_CUISSES_P2    },
        [ 1] = { xi.items.ANCHORITES_HOSE_P2      },
        [ 2] = { xi.items.THEOPHANY_PANTALOONS_P2 },
        [ 3] = { xi.items.SPAEKONAS_TONBAN_P2     },
        [ 4] = { xi.items.ATROPHY_TIGHTS_P2       },
        [ 5] = { xi.items.PILLAGERS_CULOTTES_P2   },
        [ 6] = { xi.items.REVERENCE_BREECHES_P2   },
        [ 7] = { xi.items.IGNOMINY_FLANCHARD_P2   },
        [ 8] = { xi.items.TOTEMIC_TROUSERS_P2     },
        [ 9] = { xi.items.BRIOSO_CANNIONS_P2      },
        [10] = { xi.items.ORION_BRACCAE_P2        },
        [11] = { xi.items.WAKIDO_HAIDATE_P2       },
        [12] = { xi.items.HACHIYA_HAKAMA_P2       },
        [13] = { xi.items.VISHAP_BRAIS_P2         },
        [14] = { xi.items.CONVOKERS_SPATS_P2      },
        [15] = { xi.items.ASSIMILATORS_SHALWAR_P2 },
        [16] = { xi.items.LAKSAMANAS_TREWS_P2     },
        [17] = { xi.items.FOIRE_CHURIDARS_P2      },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_TIGHTS_F_P2 },
            [1] = { xi.items.MAXIXI_TIGHTS_M_P2 },
        },

        [19] = { xi.items.ACADEMICS_PANTS_P2  },
        [20] = { xi.items.GEOMANCY_PANTS_P2   },
        [21] = { xi.items.RUNEIST_TROUSERS_P2 },
    },

    [10] = -- Deed Voucher +2: Feet
    {
        [ 0] = { xi.items.PUMMELERS_CALLIGAE_P2   },
        [ 1] = { xi.items.ANCHORITES_GAITERS_P2   },
        [ 2] = { xi.items.THEOPHANY_DUCKBILLS_P2  },
        [ 3] = { xi.items.SPAEKONAS_SABOTS_P2     },
        [ 4] = { xi.items.ATROPHY_BOOTS_P2        },
        [ 5] = { xi.items.PILLAGERS_POULAINES_P2  },
        [ 6] = { xi.items.REVERENCE_LEGGINGS_P2   },
        [ 7] = { xi.items.IGNOMINY_SOLLERETS_P2   },
        [ 8] = { xi.items.TOTEMIC_GAITERS_P2      },
        [ 9] = { xi.items.BRIOSO_SLIPPERS_P2      },
        [10] = { xi.items.ORION_SOCKS_P2          },
        [11] = { xi.items.WAKIDO_SUNE_ATE_P2      },
        [12] = { xi.items.HACHIYA_KYAHAN_P2       },
        [13] = { xi.items.VISHAP_GREAVES_P2       },
        [14] = { xi.items.CONVOKERS_PIGACHES_P2   },
        [15] = { xi.items.ASSIMILATORS_CHARUQS_P2 },
        [16] = { xi.items.LAKSAMANAS_BOTTES_P2    },
        [17] = { xi.items.FOIRE_BABOUCHES_P2      },
        [18] =
        {
            genderSpecific = true,

            [0] = { xi.items.MAXIXI_TOE_SHOES_F_P2 },
            [1] = { xi.items.MAXIXI_TOE_SHOES_M_P2 },
        },

        [19] = { xi.items.ACADEMICS_LOAFERS_P2 },
        [20] = { xi.items.GEOMANCY_SANDALS_P2  },
        [21] = { xi.items.RUNEIST_BOTTES_P2    },
    },

    [11] = -- Deed Token
    {
        [0] =
        {
            xi.items.AGOGE_MASK,
            xi.items.AGOGE_LORICA,
            xi.items.AGOGE_MUFFLERS,
            xi.items.AGOGE_CUISSES,
            xi.items.AGOGE_CALLIGAE,
        },

        [1] =
        {
            xi.items.HESYCHASTS_CROWN,
            xi.items.HESYCHASTS_CYCLAS,
            xi.items.HESYCHASTS_GLOVES,
            xi.items.HESYCHASTS_HOSE,
            xi.items.HESYCHASTS_GAITERS,
        },

        [2] =
        {
            xi.items.PIETY_CAP,
            xi.items.PIETY_BRIAULT,
            xi.items.PIETY_MITTS,
            xi.items.PIETY_PANTALOONS,
            xi.items.PIETY_DUCKBILLS,
        },

        [3] =
        {
            xi.items.ARCHMAGES_PETASOS,
            xi.items.ARCHMAGES_COAT,
            xi.items.ARCHMAGES_GLOVES,
            xi.items.ARCHMAGES_TONBAN,
            xi.items.ARCHMAGES_SABOTS,
        },

        [4] =
        {
            xi.items.VITIATION_CHAPEAU,
            xi.items.VITIATION_TABARD,
            xi.items.VITIATION_GLOVES,
            xi.items.VITIATION_TIGHTS,
            xi.items.VITIATION_BOOTS,
        },

        [5] =
        {
            xi.items.PLUNDERERS_BONNET,
            xi.items.PLUNDERERS_VEST,
            xi.items.PLUNDERERS_ARMLETS,
            xi.items.PLUNDERERS_CULOTTES,
            xi.items.PLUNDERERS_POULAINES,
        },

        [6] =
        {
            xi.items.CABALLARIUS_CORONET,
            xi.items.CABALLARIUS_SURCOAT,
            xi.items.CABALLARIUS_GAUNTLETS,
            xi.items.CABALLARIUS_BREECHES,
            xi.items.CABALLARIUS_LEGGINGS,
        },

        [7] =
        {
            xi.items.FALLENS_BURGEONET,
            xi.items.FALLENS_CUIRASS,
            xi.items.FALLENS_FINGER_GAUNTLETS,
            xi.items.FALLENS_FLANCHARD,
            xi.items.FALLENS_SOLLERETS,
        },

        [8] =
        {
            xi.items.ANKUSA_HELM,
            xi.items.ANKUSA_JACKCOAT,
            xi.items.ANKUSA_GLOVES,
            xi.items.ANKUSA_TROUSERS,
            xi.items.ANKUSA_GAITERS,
        },

        [9] =
        {
            xi.items.BIHU_ROUNDLET,
            xi.items.BIHU_JUSTAUCORPS,
            xi.items.BIHU_CUFFS,
            xi.items.BIHU_CANNIONS,
            xi.items.BIHU_SLIPPERS,
        },

        [10] =
        {
            xi.items.ARCADIAN_BERET,
            xi.items.ARCADIAN_JERKIN,
            xi.items.ARCADIAN_BRACERS,
            xi.items.ARCADIAN_BRACCAE,
            xi.items.ARCADIAN_SOCKS,
        },

        [11] =
        {
            xi.items.SAKONJI_KABUTO,
            xi.items.SAKONJI_DOMARU,
            xi.items.SAKONJI_KOTE,
            xi.items.SAKONJI_HAIDATE,
            xi.items.SAKONJI_SUNE_ATE,
        },

        [12] =
        {
            xi.items.MOCHIZUKI_HATSUBURI,
            xi.items.MOCHIZUKI_CHAINMAIL,
            xi.items.MOCHIZUKI_TEKKO,
            xi.items.MOCHIZUKI_HAKAMA,
            xi.items.MOCHIZUKI_KYAHAN,
        },

        [13] =
        {
            xi.items.PTEROSLAVER_ARMET,
            xi.items.PTEROSLAVER_MAIL,
            xi.items.PTEROSLAVER_FINGER_GAUNTLETS,
            xi.items.PTEROSLAVER_BRAIS,
            xi.items.PTEROSLAVER_GREAVES,
        },

        [14] =
        {
            xi.items.GLYPHIC_HORN,
            xi.items.GLYPHIC_DOUBLET,
            xi.items.GLYPHIC_BRACERS,
            xi.items.GLYPHIC_SPATS,
            xi.items.GLYPHIC_PIGACHES,
        },

        [15] =
        {
            xi.items.LUHLAZA_KEFFIYEH,
            xi.items.LUHLAZA_JUBBAH,
            xi.items.LUHLAZA_BAZUBANDS,
            xi.items.LUHLAZA_SHALWAR,
            xi.items.LUHLAZA_CHARUQS,
        },

        [16] =
        {
            xi.items.LANUN_TRICORNE,
            xi.items.LANUN_FRAC,
            xi.items.LANUN_GANTS,
            xi.items.LANUN_CULOTTES,
            xi.items.LANUN_BOTTES,
        },

        [17] =
        {
            xi.items.PITRE_TAJ,
            xi.items.PITRE_TOBE,
            xi.items.PITRE_DASTANAS,
            xi.items.PITRE_CHURIDARS,
            xi.items.PITRE_BABOUCHES,
        },

        [18] =
        {
            xi.items.HOROS_TIARA,
            xi.items.HOROS_CASAQUE,
            xi.items.HOROS_BANGLES,
            xi.items.HOROS_TIGHTS,
            xi.items.HOROS_TOE_SHOES,
        },

        [19] =
        {
            xi.items.PEDAGOGY_MORTARBOARD,
            xi.items.PEDAGOGY_GOWN,
            xi.items.PEDAGOGY_BRACERS,
            xi.items.PEDAGOGY_PANTS,
            xi.items.PEDAGOGY_LOAFERS,
        },

        [20] =
        {
            xi.items.BAGUA_GALERO,
            xi.items.BAGUA_TUNIC,
            xi.items.BAGUA_MITAINES,
            xi.items.BAGUA_PANTS,
            xi.items.BAGUA_SANDALS,
        },

        [21] =
        {
            xi.items.FUTHARK_BANDEAU,
            xi.items.FUTHARK_COAT,
            xi.items.FUTHARK_MITONS,
            xi.items.FUTHARK_TROUSERS,
            xi.items.FUTHARK_BOOTS,
        },
    },

    [12] = -- Deed Token +1: Head
    {
        [ 0] = { xi.items.AGOGE_MASK_P1           },
        [ 1] = { xi.items.HESYCHASTS_CROWN_P1     },
        [ 2] = { xi.items.PIETY_CAP_P1            },
        [ 3] = { xi.items.ARCHMAGES_PETASOS_P1    },
        [ 4] = { xi.items.VITIATION_CHAPEAU_P1    },
        [ 5] = { xi.items.PLUNDERERS_BONNET_P1    },
        [ 6] = { xi.items.CABALLARIUS_CORONET_P1  },
        [ 7] = { xi.items.FALLENS_BURGEONET_P1    },
        [ 8] = { xi.items.ANKUSA_HELM_P1          },
        [ 9] = { xi.items.BIHU_ROUNDLET_P1        },
        [10] = { xi.items.ARCADIAN_BERET_P1       },
        [11] = { xi.items.SAKONJI_KABUTO_P1       },
        [12] = { xi.items.MOCHIZUKI_HATSUBURI_P1  },
        [13] = { xi.items.PTEROSLAVER_ARMET_P1    },
        [14] = { xi.items.GLYPHIC_HORN_P1         },
        [15] = { xi.items.LUHLAZA_KEFFIYEH_P1     },
        [16] = { xi.items.LANUN_TRICORNE_P1       },
        [17] = { xi.items.PITRE_TAJ_P1            },
        [18] = { xi.items.HOROS_TIARA_P1          },
        [19] = { xi.items.PEDAGOGY_MORTARBOARD_P1 },
        [20] = { xi.items.BAGUA_GALERO_P1         },
        [21] = { xi.items.FUTHARK_BANDEAU_P1      },
    },

    [13] = -- Deed Token +1: Chest
    {
        [ 0] = { xi.items.AGOGE_LORICA_P1        },
        [ 1] = { xi.items.HESYCHASTS_CYCLAS_P1   },
        [ 2] = { xi.items.PIETY_BRIAULT_P1       },
        [ 3] = { xi.items.ARCHMAGES_COAT_P1      },
        [ 4] = { xi.items.VITIATION_TABARD_P1    },
        [ 5] = { xi.items.PLUNDERERS_VEST_P1     },
        [ 6] = { xi.items.CABALLARIUS_SURCOAT_P1 },
        [ 7] = { xi.items.FALLENS_CUIRASS_P1     },
        [ 8] = { xi.items.ANKUSA_JACKCOAT_P1     },
        [ 9] = { xi.items.BIHU_JUSTAUCORPS_P1    },
        [10] = { xi.items.ARCADIAN_JERKIN_P1     },
        [11] = { xi.items.SAKONJI_DOMARU_P1      },
        [12] = { xi.items.MOCHIZUKI_CHAINMAIL_P1 },
        [13] = { xi.items.PTEROSLAVER_MAIL_P1    },
        [14] = { xi.items.GLYPHIC_DOUBLET_P1     },
        [15] = { xi.items.LUHLAZA_JUBBAH_P1      },
        [16] = { xi.items.LANUN_FRAC_P1          },
        [17] = { xi.items.PITRE_TOBE_P1          },
        [18] = { xi.items.HOROS_CASAQUE_P1       },
        [19] = { xi.items.PEDAGOGY_GOWN_P1       },
        [20] = { xi.items.BAGUA_TUNIC_P1         },
        [21] = { xi.items.FUTHARK_COAT_P1        },
    },

    [14] = -- Deed Token +1: Hands
    {
        [ 0] = { xi.items.AGOGE_MUFFLERS_P1               },
        [ 1] = { xi.items.HESYCHASTS_GLOVES_P1            },
        [ 2] = { xi.items.PIETY_MITTS_P1                  },
        [ 3] = { xi.items.ARCHMAGES_GLOVES_P1             },
        [ 4] = { xi.items.VITIATION_GLOVES_P1             },
        [ 5] = { xi.items.PLUNDERERS_ARMLETS_P1           },
        [ 6] = { xi.items.CABALLARIUS_GAUNTLETS_P1        },
        [ 7] = { xi.items.FALLENS_FINGER_GAUNTLETS_P1     },
        [ 8] = { xi.items.ANKUSA_GLOVES_P1                },
        [ 9] = { xi.items.BIHU_CUFFS_P1                   },
        [10] = { xi.items.ARCADIAN_BRACERS_P1             },
        [11] = { xi.items.SAKONJI_KOTE_P1                 },
        [12] = { xi.items.MOCHIZUKI_TEKKO_P1              },
        [13] = { xi.items.PTEROSLAVER_FINGER_GAUNTLETS_P1 },
        [14] = { xi.items.GLYPHIC_BRACERS_P1              },
        [15] = { xi.items.LUHLAZA_BAZUBANDS_P1            },
        [16] = { xi.items.LANUN_GANTS_P1                  },
        [17] = { xi.items.PITRE_DASTANAS_P1               },
        [18] = { xi.items.HOROS_BANGLES_P1                },
        [19] = { xi.items.PEDAGOGY_BRACERS_P1             },
        [20] = { xi.items.BAGUA_MITAINES_P1               },
        [21] = { xi.items.FUTHARK_MITONS_P1               },
    },

    [15] = -- Deed Token +1: Legs
    {
        [ 0] = { xi.items.AGOGE_CUISSES_P1        },
        [ 1] = { xi.items.HESYCHASTS_HOSE_P1      },
        [ 2] = { xi.items.PIETY_PANTALOONS_P1     },
        [ 3] = { xi.items.ARCHMAGES_TONBAN_P1     },
        [ 4] = { xi.items.VITIATION_TIGHTS_P1     },
        [ 5] = { xi.items.PLUNDERERS_CULOTTES_P1  },
        [ 6] = { xi.items.CABALLARIUS_BREECHES_P1 },
        [ 7] = { xi.items.FALLENS_FLANCHARD_P1    },
        [ 8] = { xi.items.ANKUSA_TROUSERS_P1      },
        [ 9] = { xi.items.BIHU_CANNIONS_P1        },
        [10] = { xi.items.ARCADIAN_BRACCAE_P1     },
        [11] = { xi.items.SAKONJI_HAIDATE_P1      },
        [12] = { xi.items.MOCHIZUKI_HAKAMA_P1     },
        [13] = { xi.items.PTEROSLAVER_BRAIS_P1    },
        [14] = { xi.items.GLYPHIC_SPATS_P1        },
        [15] = { xi.items.LUHLAZA_SHALWAR_P1      },
        [16] = { xi.items.LANUN_CULOTTES_P1       },
        [17] = { xi.items.PITRE_CHURIDARS_P1      },
        [18] = { xi.items.HOROS_TIGHTS_P1         },
        [19] = { xi.items.PEDAGOGY_PANTS_P1       },
        [20] = { xi.items.BAGUA_PANTS_P1          },
        [21] = { xi.items.FUTHARK_TROUSERS_P1     },
    },

    [16] = -- Deed Token +1: Feet
    {
        [ 0] = { xi.items.AGOGE_CALLIGAE_P1       },
        [ 1] = { xi.items.HESYCHASTS_GAITERS_P1   },
        [ 2] = { xi.items.PIETY_DUCKBILLS_P1      },
        [ 3] = { xi.items.ARCHMAGES_SABOTS_P1     },
        [ 4] = { xi.items.VITIATION_BOOTS_P1      },
        [ 5] = { xi.items.PLUNDERERS_POULAINES_P1 },
        [ 6] = { xi.items.CABALLARIUS_LEGGINGS_P1 },
        [ 7] = { xi.items.FALLENS_SOLLERETS_P1    },
        [ 8] = { xi.items.ANKUSA_GAITERS_P1       },
        [ 9] = { xi.items.BIHU_SLIPPERS_P1        },
        [10] = { xi.items.ARCADIAN_SOCKS_P1       },
        [11] = { xi.items.SAKONJI_SUNE_ATE_P1     },
        [12] = { xi.items.MOCHIZUKI_KYAHAN_P1     },
        [13] = { xi.items.PTEROSLAVER_GREAVES_P1  },
        [14] = { xi.items.GLYPHIC_PIGACHES_P1     },
        [15] = { xi.items.LUHLAZA_CHARUQS_P1      },
        [16] = { xi.items.LANUN_BOTTES_P1         },
        [17] = { xi.items.PITRE_BABOUCHES_P1      },
        [18] = { xi.items.HOROS_TOE_SHOES_P1      },
        [19] = { xi.items.PEDAGOGY_LOAFERS_P1     },
        [20] = { xi.items.BAGUA_SANDALS_P1        },
        [21] = { xi.items.FUTHARK_BOOTS_P1        },
    },

    [17] = -- Deed Token +2: Head
    {
        [ 0] = { xi.items.AGOGE_MASK_P2           },
        [ 1] = { xi.items.HESYCHASTS_CROWN_P2     },
        [ 2] = { xi.items.PIETY_CAP_P2            },
        [ 3] = { xi.items.ARCHMAGES_PETASOS_P2    },
        [ 4] = { xi.items.VITIATION_CHAPEAU_P2    },
        [ 5] = { xi.items.PLUNDERERS_BONNET_P2    },
        [ 6] = { xi.items.CABALLARIUS_CORONET_P2  },
        [ 7] = { xi.items.FALLENS_BURGEONET_P2    },
        [ 8] = { xi.items.ANKUSA_HELM_P2          },
        [ 9] = { xi.items.BIHU_ROUNDLET_P2        },
        [10] = { xi.items.ARCADIAN_BERET_P2       },
        [11] = { xi.items.SAKONJI_KABUTO_P2       },
        [12] = { xi.items.MOCHIZUKI_HATSUBURI_P2  },
        [13] = { xi.items.PTEROSLAVER_ARMET_P2    },
        [14] = { xi.items.GLYPHIC_HORN_P2         },
        [15] = { xi.items.LUHLAZA_KEFFIYEH_P2     },
        [16] = { xi.items.LANUN_TRICORNE_P2       },
        [17] = { xi.items.PITRE_TAJ_P2            },
        [18] = { xi.items.HOROS_TIARA_P2          },
        [19] = { xi.items.PEDAGOGY_MORTARBOARD_P2 },
        [20] = { xi.items.BAGUA_GALERO_P2         },
        [21] = { xi.items.FUTHARK_BANDEAU_P2      },
    },

    [18] = -- Deed Token +2: Chest
    {
        [ 0] = { xi.items.AGOGE_LORICA_P2        },
        [ 1] = { xi.items.HESYCHASTS_CYCLAS_P2   },
        [ 2] = { xi.items.PIETY_BRIAULT_P2       },
        [ 3] = { xi.items.ARCHMAGES_COAT_P2      },
        [ 4] = { xi.items.VITIATION_TABARD_P2    },
        [ 5] = { xi.items.PLUNDERERS_VEST_P2     },
        [ 6] = { xi.items.CABALLARIUS_SURCOAT_P2 },
        [ 7] = { xi.items.FALLENS_CUIRASS_P2     },
        [ 8] = { xi.items.ANKUSA_JACKCOAT_P2     },
        [ 9] = { xi.items.BIHU_JUSTAUCORPS_P2    },
        [10] = { xi.items.ARCADIAN_JERKIN_P2     },
        [11] = { xi.items.SAKONJI_DOMARU_P2      },
        [12] = { xi.items.MOCHIZUKI_CHAINMAIL_P2 },
        [13] = { xi.items.PTEROSLAVER_MAIL_P2    },
        [14] = { xi.items.GLYPHIC_DOUBLET_P2     },
        [15] = { xi.items.LUHLAZA_JUBBAH_P2      },
        [16] = { xi.items.LANUN_FRAC_P2          },
        [17] = { xi.items.PITRE_TOBE_P2          },
        [18] = { xi.items.HOROS_CASAQUE_P2       },
        [19] = { xi.items.PEDAGOGY_GOWN_P2       },
        [20] = { xi.items.BAGUA_TUNIC_P2         },
        [21] = { xi.items.FUTHARK_COAT_P2        },
    },

    [19] = -- Deed Token +2: Hands
    {
        [ 0] = { xi.items.AGOGE_MUFFLERS_P2               },
        [ 1] = { xi.items.HESYCHASTS_GLOVES_P2            },
        [ 2] = { xi.items.PIETY_MITTS_P2                  },
        [ 3] = { xi.items.ARCHMAGES_GLOVES_P2             },
        [ 4] = { xi.items.VITIATION_GLOVES_P2             },
        [ 5] = { xi.items.PLUNDERERS_ARMLETS_P2           },
        [ 6] = { xi.items.CABALLARIUS_GAUNTLETS_P2        },
        [ 7] = { xi.items.FALLENS_FINGER_GAUNTLETS_P2     },
        [ 8] = { xi.items.ANKUSA_GLOVES_P2                },
        [ 9] = { xi.items.BIHU_CUFFS_P2                   },
        [10] = { xi.items.ARCADIAN_BRACERS_P2             },
        [11] = { xi.items.SAKONJI_KOTE_P2                 },
        [12] = { xi.items.MOCHIZUKI_TEKKO_P2              },
        [13] = { xi.items.PTEROSLAVER_FINGER_GAUNTLETS_P2 },
        [14] = { xi.items.GLYPHIC_BRACERS_P2              },
        [15] = { xi.items.LUHLAZA_BAZUBANDS_P2            },
        [16] = { xi.items.LANUN_GANTS_P2                  },
        [17] = { xi.items.PITRE_DASTANAS_P2               },
        [18] = { xi.items.HOROS_BANGLES_P2                },
        [19] = { xi.items.PEDAGOGY_BRACERS_P2             },
        [20] = { xi.items.BAGUA_MITAINES_P2               },
        [21] = { xi.items.FUTHARK_MITONS_P2               },
    },

    [20] = -- Deed Token +2: Legs
    {
        [ 0] = { xi.items.AGOGE_CUISSES_P2        },
        [ 1] = { xi.items.HESYCHASTS_HOSE_P2      },
        [ 2] = { xi.items.PIETY_PANTALOONS_P2     },
        [ 3] = { xi.items.ARCHMAGES_TONBAN_P2     },
        [ 4] = { xi.items.VITIATION_TIGHTS_P2     },
        [ 5] = { xi.items.PLUNDERERS_CULOTTES_P2  },
        [ 6] = { xi.items.CABALLARIUS_BREECHES_P2 },
        [ 7] = { xi.items.FALLENS_FLANCHARD_P2    },
        [ 8] = { xi.items.ANKUSA_TROUSERS_P2      },
        [ 9] = { xi.items.BIHU_CANNIONS_P2        },
        [10] = { xi.items.ARCADIAN_BRACCAE_P2     },
        [11] = { xi.items.SAKONJI_HAIDATE_P2      },
        [12] = { xi.items.MOCHIZUKI_HAKAMA_P2     },
        [13] = { xi.items.PTEROSLAVER_BRAIS_P2    },
        [14] = { xi.items.GLYPHIC_SPATS_P2        },
        [15] = { xi.items.LUHLAZA_SHALWAR_P2      },
        [16] = { xi.items.LANUN_CULOTTES_P2       },
        [17] = { xi.items.PITRE_CHURIDARS_P2      },
        [18] = { xi.items.HOROS_TIGHTS_P2         },
        [19] = { xi.items.PEDAGOGY_PANTS_P2       },
        [20] = { xi.items.BAGUA_PANTS_P2          },
        [21] = { xi.items.FUTHARK_TROUSERS_P2     },
    },

    [21] = -- Deed Token +2: Feet
    {
        [ 0] = { xi.items.AGOGE_CALLIGAE_P2       },
        [ 1] = { xi.items.HESYCHASTS_GAITERS_P2   },
        [ 2] = { xi.items.PIETY_DUCKBILLS_P2      },
        [ 3] = { xi.items.ARCHMAGES_SABOTS_P2     },
        [ 4] = { xi.items.VITIATION_BOOTS_P2      },
        [ 5] = { xi.items.PLUNDERERS_POULAINES_P2 },
        [ 6] = { xi.items.CABALLARIUS_LEGGINGS_P2 },
        [ 7] = { xi.items.FALLENS_SOLLERETS_P2    },
        [ 8] = { xi.items.ANKUSA_GAITERS_P2       },
        [ 9] = { xi.items.BIHU_SLIPPERS_P2        },
        [10] = { xi.items.ARCADIAN_SOCKS_P2       },
        [11] = { xi.items.SAKONJI_SUNE_ATE_P2     },
        [12] = { xi.items.MOCHIZUKI_KYAHAN_P2     },
        [13] = { xi.items.PTEROSLAVER_GREAVES_P2  },
        [14] = { xi.items.GLYPHIC_PIGACHES_P2     },
        [15] = { xi.items.LUHLAZA_CHARUQS_P2      },
        [16] = { xi.items.LANUN_BOTTES_P2         },
        [17] = { xi.items.PITRE_BABOUCHES_P2      },
        [18] = { xi.items.HOROS_TOE_SHOES_P2      },
        [19] = { xi.items.PEDAGOGY_LOAFERS_P2     },
        [20] = { xi.items.BAGUA_SANDALS_P2        },
        [21] = { xi.items.FUTHARK_BOOTS_P2        },
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
