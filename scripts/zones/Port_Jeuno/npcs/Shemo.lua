-----------------------------------
-- Area: Port Jeuno
--  NPC: Shemo
-----------------------------------
---@type TNpcEntity
local entity = {}

local beastmanSeal       = 0
local kindredSeal        = 1
local kindredCrest       = 2
local highKindredCrest   = 3
local sacredKindredCrest = 4

-- 0:Convert at 3: 1
-- 1:Convert at 2: 1 (campaignAdditional Seal Battlefield Spoils Campaign)
local isTradeNum2 = 0

entity.onTrade = function(player, npc, trade)
    local eventParams = { 353, 0, 0, 0, 0, 0 }

    xi.seals.onTrade(player, npc, trade, eventParams)
end

entity.onTrigger = function(player, npc)
    local csid        = 352
    local sealShift   = {}
    local hideOptions = 0

    sealShift[1] = player:getSeals(beastmanSeal)
    sealShift[2] = bit.lshift(player:getSeals(kindredSeal), 16)
    sealShift[3] = player:getSeals(kindredCrest)
    sealShift[4] = bit.lshift(player:getSeals(highKindredCrest), 16)
    sealShift[5] = player:getSeals(sacredKindredCrest)

    local sealBit1 = bit.bor(sealShift[1], sealShift[2])
    local sealBit2 = bit.bor(sealShift[3], sealShift[4])
    local sealBit3 = bit.bor(sealShift[5], 0)

    for i = 1, #sealShift do
        if sealShift[i] < 2 then
            hideOptions = bit.bor(hideOptions, bit.lshift(1, i - 1))
        end
    end

    local shemoTradesCount = player:getCharVar('ShemoTrades') -- Skips first menu if player has traded before
    player:startEvent(csid, sealBit1, sealBit2, sealBit3, isTradeNum2, 0, 0, 0, math.min(shemoTradesCount, 1))
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 352 then
        local addnum    = bit.rshift(option, 8)
        local outSeal   = bit.rshift(bit.band(option, 0xFF), 4) - 1
        local inSeal    = bit.band(option, 0xF) - 1
        local dellseals = addnum * 3

        if isTradeNum2 == 1 then
            dellseals = addnum * 2
        end

        if inSeal >= 0 and outSeal >= 0 then
            player:delSeals(dellseals, outSeal)
            player:addSeals(addnum, inSeal)
            player:incrementCharVar('ShemoTrades', 1)
        end
    end
end

return entity
