-----------------------------------
-- Area: Al Zahbi
--  NPC: Gajaad
-- Type: Donation Taker
-- !pos 40.781 -1.398 116.261 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

local function giveReward(player, npc, param)
    local reward = player:getCharVar('walahraPendingReward')
    local total  = math.floor(player:getCharVar('walahraCoinCount') / 100) * 100

    player:showText(npc, ID.text.GAJAAD_DONATION_REWARD, param, total, 0, 0, false, true, 2)

    local messageId = ID.text.ITEM_CANNOT_BE_OBTAINED
    if npcUtil.giveItem(player, reward, { silent = true }) then
        messageId = ID.text.ITEM_OBTAINED
        player:setCharVar('walahraPendingReward', 0)

        -- Excess coins do not carry over.
        if reward == xi.item.WALAHRA_TURBAN then
            player:setCharVar('walahraCoinCount', 0)
        end
    end

    player:showText(npc, bit.bor(messageId, 0x8000), reward, total, 0, 0, false, false, 6)
end

entity.onTrade = function(player, npc, trade)
    -- TODO: Verify whether unclaimed Water blocks donations.
    if player:getCharVar('walahraPendingReward') ~= 0 then
        return
    end

    local tradeCount = trade:getItemQty(xi.item.IMPERIAL_BRONZE_PIECE)
    if
        tradeCount == 0 or
        not npcUtil.tradeMatches(trade, { { xi.item.IMPERIAL_BRONZE_PIECE, tradeCount } })
    then
        return
    end

    local oldTotal = player:getCharVar('walahraCoinCount')
    local newTotal = oldTotal + tradeCount
    local reward   = 0

    if newTotal >= 1000 then
        newTotal = 1000
        reward   = xi.item.WALAHRA_TURBAN
    -- Only one Water per trade.
    elseif math.floor(newTotal / 100) > math.floor(oldTotal / 100) then
        reward = xi.item.FLASK_OF_WALAHRA_WATER
    end

    -- Free the coin slots before giving the reward.
    if not player:tradeComplete() then
        return
    end

    player:setCharVar('walahraCoinCount', newTotal)

    -- Donating cancels the donor's pending yell.
    if npc:getLocalVar('reminderTarget') == player:getID() then
        npc:setLocalVar('reminderTarget', 0)
    end

    if reward ~= 0 then
        player:setCharVar('walahraPendingReward', reward)
        giveReward(player, npc, tradeCount)
    else
        player:showText(npc, ID.text.GAJAAD_DONATION_THANKS, tradeCount, newTotal, 0, 0, false, true, 2)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('walahraPendingReward') ~= 0 then
        -- TODO: Explain the zone ID in the first retry parameter.
        giveReward(player, npc, xi.zone.AL_ZAHBI)
        return
    end

    -- TODO besiege result can effect if this NPC will accept trades
    -- TODO: Identify parameters 5/6 (6098/29, 6098/54, or 0/0).
    player:startEvent(102, xi.item.IMPERIAL_BRONZE_PIECE, 1, player:getCharVar('walahraCoinCount'), 0, 0, 0, 3, xi.item.IMPERIAL_BRONZE_PIECE)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid ~= 102 or option ~= 1 then
        return
    end

    -- The latest signature replaces the pending yell.
    local sequence = npc:getLocalVar('reminderSequence') + 1
    npc:setLocalVar('reminderSequence', sequence)
    npc:setLocalVar('reminderTarget', player:getID())
    npc:timer(13000, function(npcArg)
        if npcArg:getLocalVar('reminderSequence') ~= sequence then
            return
        end

        local targetId = npcArg:getLocalVar('reminderTarget')
        npcArg:setLocalVar('reminderTarget', 0)
        if targetId == 0 or npcArg:getStatus() ~= xi.status.NORMAL then
            return
        end

        local target = GetPlayerByID(targetId)
        if not target or target:getZoneID() ~= npcArg:getZoneID() then
            return
        end

        local mainJob   = target:getMainJob()
        local mainLevel = target:getMainLvl()

        -- The named player can be outside yell range.
        for _, listener in pairs(npcArg:getZone():getPlayers()) do
            if listener:checkDistance(npcArg) <= 30 then
                listener:messageName(ID.text.GAJAAD_DONATION_REMINDER, target, mainJob, mainLevel, 0, 0, 0, npcArg)
            end
        end
    end)
end

return entity
