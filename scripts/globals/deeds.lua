-----------------------------------
-- Deeds of Heroism (A.M.A.N. Validator)
-----------------------------------
-- Bastok Markets      : !pos -338.18 -10 -180.19 235
-- Southern San d'Oria : !pos -83.07 1 -55.58 230
-- Windurst Woods      : !pos 89.9 -4.2 -47.63 241
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
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

-- Subtables to determine what items can be rewarded per store voucher
local voucherData =
{

}

local function getStoredVoucherMask(player)
    local voucherMask = 0

    -- TODO: This may involve two separate uint32 bitfields
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

    player:updateEvent(
        numDeeds,
        claimedRewards[1],
        claimedRewards[2],
        claimedRewards[3],
        claimedRewards[4],
        claimedRewards[5],
        storedVouchers,
        0
    )
end

xi.deeds.validatorOnTrigger = function(player, npc)
    local zoneId         = player:getZoneID()
    local numDeeds       = player:getCurrency('deeds')
    local claimedRewards = player:getClaimedDeedMask()
    local storedVouchers = getStoredVoucherMask(player)

    -- TODO: Other event parameters are probably an extended mask
    player:startEvent(validatorNpcEvents[zoneId],
        numDeeds,
        claimedRewards[1],
        claimedRewards[2],
        claimedRewards[3],
        claimedRewards[4],
        claimedRewards[5],
        storedVouchers,
        0
    )
end

xi.deeds.validatorOnEventUpdate = function(player, csid, option, npc)
    -- TODO: Determine what happens if inventory is full, or rare/ex item cannot
    -- be obtained.
    local updateAction = bit.rshift(option, 16)
    local updateOption = bit.band(option, 0xFFFF)
    local bitLocation  = updateOption

    -- NOTE: Resettable rewards (970+) are handled in the same table; however, the stored
    -- data is offset by one bit in the fourth parameter.  This block handles the conversion
    -- for the following condition.
    if updateAction == 3 then
        updateAction = 1
        updateOption = updateOption > 0 and updateOption + 96 or 0
        bitLocation  = updateOption + 1
    end

    if
        updateAction == 1 and
        validatorRewards[updateOption]
    then
        player:setClaimedDeed(bitLocation)

        local claimedRewards = player:getClaimedDeedMask()
        local numDeeds       = player:getCurrency('deeds')
        local totalCost      = 480 * bit.rshift(claimedRewards[5], 18) + updateOption * 10

        if numDeeds < totalCost then
            return
        end

        updateValidatorEvent(player)

        if validatorRewards[updateOption]['keyItemId'] then
            npcUtil.giveKeyItem(player, validatorRewards[updateOption]['keyItemId'])
        else
            npcUtil.giveItem(player, { { validatorRewards[updateOption]['itemId'], validatorRewards[updateOption]['qty'] } })
        end
    elseif updateAction == 4 and updateOption == 0 then
        player:resetClaimedDeeds()

        updateValidatorEvent(player)
    end
end

xi.deeds.validatorOnEventFinish = function(player, csid, option, npc)
end
