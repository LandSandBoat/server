-----------------------------------
-- Area: Port Jeuno
--  NPC: Shemo
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local beastman_seal = 0
local kindred_seal = 1
local kindred_crest = 2
local high_kindred_crest = 3
local sacred_kindred_crest = 4

-- 0:Convert at 3: 1
-- 1:Convert at 2: 1 (campaignAdditional Seal Battlefield Spoils Campaign)
local isTradeNum2 = 0

entity.onTrigger = function(player, npc)
    local csid = 352
    local sealShift = {}
    local hideOptions = 0

    sealShift[1] = player:getSeals(beastman_seal)
    sealShift[2] = bit.lshift(player:getSeals(kindred_seal), 16)
    sealShift[3] = player:getSeals(kindred_crest)
    sealShift[4] = bit.lshift(player:getSeals(high_kindred_crest), 16)
    sealShift[5] = player:getSeals(sacred_kindred_crest)

    local sealBit1 = bit.bor(sealShift[1], sealShift[2])
    local sealBit2 = bit.bor(sealShift[3], sealShift[4])
    local sealBit3 = bit.bor(sealShift[5], 0)

    for i=1, #sealShift do
        if sealShift[i] < 2 then
            hideOptions = bit.bor(hideOptions, bit.lshift(1, i - 1))
        end
    end

    player:startEvent(csid, sealBit1, sealBit2, sealBit3, isTradeNum2)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 352 then
        local addnum = bit.rshift(option, 8)
        local out_seal = bit.rshift(bit.band(option, 0xFF), 4) - 1
        local in_seal = bit.band(option, 0xF) - 1
        local dellseals = addnum * 3
        if isTradeNum2 == 1 then
            dellseals = addnum * 2
        end

        if in_seal >= 0 and out_seal >= 0 then
            player:delSeals(dellseals, out_seal)
            player:addSeals(addnum, in_seal)
        end

    end
end

return entity
