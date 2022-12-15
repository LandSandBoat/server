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
local validatorRewards =
{
    [1] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,  qty =  7 },
    [2] = { itemId    = xi.items.MOGGIEBAG,            qty =  1 },
    [3] = { itemId    = xi.items.ENDORSEMENT_RING,     qty =  1 },
    [4] = { itemId    = xi.items.THEMIS_ORB,           qty =  1 },
    [5] = { itemId    = xi.items.COPPER_AMAN_VOUCHER,  qty = 14 },
    [6] = { itemId    = xi.items.MOOGLES_LARGESSE,     qty =  1 },
    [7] = { keyItemId = xi.ki.DEED_VOUCHER                      },
}

-- Key items by Bit to determine storedVoucher Mask
local voucherKeyItems =
{
    xi.ki.DEED_VOUCHER,
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
    -- TODO: Determine what happens if inventory is full, or keyitem has already
    -- been obtained prior to resetting.
    local numDeeds     = player:getCurrency('deeds')
    local updateAction = bit.rshift(option, 16)
    local updateOption = bit.band(option, 0xFFFF)

    if
        updateAction == 1 and
        validatorRewards[updateOption] and
        numDeeds >= updateOption * 10
    then
        player:setClaimedDeed(updateOption)

        local claimedRewards = player:getClaimedDeedMask()
        local storedVouchers = getStoredVoucherMask(player)

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

        if validatorRewards[updateOption]['keyItemId'] then
            npcUtil.giveKeyItem(player, validatorRewards[updateOption]['keyItemId'])
        else
            npcUtil.giveItem(player, { { validatorRewards[updateOption]['itemId'], validatorRewards[updateOption]['qty']} })
        end
    end
end

xi.deeds.validatorOnEventFinish = function(player, csid, option, npc)
end
