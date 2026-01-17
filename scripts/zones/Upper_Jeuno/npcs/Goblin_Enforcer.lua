-----------------------------------
-- Area: Upper Jeuno
--  NPC: Goblin Enforcer
-- Custom: Goblin Mafia NM Hunt
-- !pos 3 1 77 244
-----------------------------------
require('modules/custom/lua/gobhook')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local contractId = player:getVar('MafiaContractId')

    -- Pay 50k gil to reset current hunt
    if npcUtil.tradeHasExactly(trade, { { xi.item.GIL, 50000 } }) then
        player:confirmTrade()
        player:setVar('MafiaContractId', 0)
        player:printToPlayer('Very well I\'ll think of another Hit you can do.', xi.msg.channel.SAY, 'Goblin Enforcer')

    -- No active hunt assigned
    elseif contractId == 0 then
        player:printToPlayer('You have no Hit assigned to you, check the game table for a job.', xi.msg.channel.SAY, 'Goblin Enforcer')

    -- Trade the hunt item
    elseif xi.mafia.CONTRACTS[contractId] and npcUtil.tradeHasExactly(trade, { { xi.mafia.CONTRACTS[contractId].item, 1 } }) then
        player:confirmTrade()
        local contract = xi.mafia.CONTRACTS[contractId]

        -- Both objectives completed (killed NM + got item)
        if player:getVar('MafiaHuntKilled') == 1 then
            local totalReward = contract.reward + contract.bonus + 500
            player:printToPlayer(string.format('Nice you found %s and retrieved my %s.', contract.mobName, contract.itemName), xi.msg.channel.SAY, 'Goblin Enforcer')
            player:printToPlayer(string.format('I have your bounty plus a bonus for getting both objectives. Reward: %s', totalReward), xi.msg.channel.SAY, 'Goblin Enforcer')
            player:addCurrency('legion_point', totalReward)
            player:printToPlayer(string.format('Mafia Reputation went up %s', totalReward), xi.msg.channel.SAY, 'Goblin Enforcer')
            player:setVar('MafiaContractId', 0)
            player:setVar('MafiaHuntKilled', 0)
            player:setVar('MafiaCurrentMob', 0)

        -- Only got item, didn't kill NM
        else
            player:printToPlayer(string.format('Well you found my %s but were unable to \'Take care\' of %s.', contract.itemName, contract.mobName), xi.msg.channel.SAY, 'Goblin Enforcer')
            player:printToPlayer(string.format('I can only give you %s for your efforts.', contract.bonus), xi.msg.channel.SAY, 'Goblin Enforcer')
            player:addCurrency('legion_point', contract.bonus)
            player:printToPlayer(string.format('Mafia Reputation went up %s', contract.bonus), xi.msg.channel.SAY, 'Goblin Enforcer')
            player:setVar('MafiaContractId', 0)
            player:setVar('MafiaHuntKilled', 0)
            player:setVar('MafiaCurrentMob', 0)
        end

    -- Wrong item traded
    else
        local contract = xi.mafia.CONTRACTS[contractId]
        if contract then
            player:printToPlayer(string.format('This isn\'t what I\'m looking for. I want %s head or my property: %s', contract.mobName, contract.itemName), xi.msg.channel.SAY, 'Goblin Enforcer')
        end
    end
end

entity.onTrigger = function(player, npc)
    local contractId = player:getVar('MafiaContractId')

    -- No active hunt
    if contractId == 0 then
        player:printToPlayer('I hear your the guy I can count on, I have a problem I\'d like to rectify.', xi.msg.channel.SAY, 'Goblin Enforcer')
        player:printToPlayer('Theres this \'Associate\' that hasnt paid his dues and we need him taken down a peg, if you catch my drift.', xi.msg.channel.SAY, 'Goblin Enforcer')
        player:printToPlayer('I left a ledger out for you to go take a peek at and see if you can rectify my problem. It\'s at the Game Table by Home Point 3.', xi.msg.channel.SAY, 'Goblin Enforcer')

    -- Killed NM but didn't get item yet
    elseif player:getVar('MafiaHuntKilled') == 1 then
        local contract = xi.mafia.CONTRACTS[contractId]
        if contract then
            player:printToPlayer(string.format('You found %s! Too bad you couldn\'t recover the %s also.', contract.mobName, contract.itemName), xi.msg.channel.SAY, 'Goblin Enforcer')
            player:printToPlayer(string.format('Your bounty is %s. Come back if you want more work.', contract.reward), xi.msg.channel.SAY, 'Goblin Enforcer')
            player:addCurrency('legion_point', contract.reward)
            player:setVar('MafiaContractId', 0)
            player:setVar('MafiaHuntKilled', 0)
            player:setVar('MafiaCurrentMob', 0)
        end

    -- Active hunt in progress
    else
        player:printToPlayer('If you dont think you can handle the job we can arrange for another contract for .... 50k Gil.', xi.msg.channel.SAY, 'Goblin Enforcer')
    end
end

return entity
