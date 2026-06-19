-----------------------------------
-- Area: Upper Jeuno
--  NPC: Game Table
-- Custom: Goblin Mafia Contract Selection
-----------------------------------
require('modules/custom/lua/gobhook')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local contractId = player:getVar('MafiaContractId')

    -- No active contract - assign a new random one
    if contractId == 0 then
        local randomContract = math.random(1, #xi.mafia.CONTRACTS)
        player:setVar('MafiaContractId', randomContract)

        local contract = xi.mafia.CONTRACTS[randomContract]
        player:setVar('MafiaCurrentMob', contract.mobId)

        player:printToPlayer(string.format('This guy %s been dodging me for some time and I want him \'TAKEN OUT\'', contract.mobName), xi.msg.channel.SAY, 'Goblin Mafia')
        player:printToPlayer(string.format('Come back with either proof of death and/or what he owes me: %s', contract.itemName), xi.msg.channel.SAY, 'Goblin Mafia')
        player:printToPlayer(string.format('I have a bounty of %s for this guy, I\'ll give you %s if you recover my property and I can give you a bonus if you can complete both.', contract.reward, contract.bonus), xi.msg.channel.SAY, 'Goblin Mafia')
        player:printToPlayer('If you dont think you can handle the job we can arrange for another contract for .... 50k Gil', xi.msg.channel.SAY, 'Goblin Mafia')

    -- Already has active contract - remind them
    else
        local contract = xi.mafia.CONTRACTS[contractId]
        if contract then
            player:printToPlayer(string.format('I need you to take \'care of\' %s', contract.mobName), xi.msg.channel.SAY, 'Goblin Mafia')
            player:printToPlayer(string.format('If you rough him up enough and bring me back my %s I\'ll add a bonus to your bounty', contract.itemName), xi.msg.channel.SAY, 'Goblin Mafia')
            player:printToPlayer(string.format('Bounty Pay: %s Bonus Pay: %s', contract.reward, contract.bonus), xi.msg.channel.SAY, 'Goblin Mafia')
        end
    end
end

return entity
