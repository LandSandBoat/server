-----------------------------------
-- func: mobhunt <command> <args...>
-- desc: Allows players to participate in the Mob Hunt event with !mobhunt join
--       Also allows GMs to control the Mob Hunt event.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 'ss'
}

commandObj.onTrigger = function(player, command, arg1)
    command = string.lower(command or '')

    if
        not xi.events.mobHunt.getIsActive() and
        command ~= 'cleanup' and
        command ~= 'quit'
    then
        return
    end

    local gmLevel = player:getGMLevel()

    if command == 'new' and gmLevel >= 1 then
        xi.events.mobHunt.activateNewHuntTarget()

        local mobHuntTargetID = GetServerVariable('[MobHunt]Target')
        player:printToPlayer('New Mob Hunt target: ' .. mobHuntTargetID .. '.')
    elseif command == 'set' and gmLevel >= 1 then
        local targetID = tonumber(arg1 or '')
        ---@diagnostic disable-next-line: param-type-mismatch
        local target   = targetID and GetMobByID(math.floor(targetID)) or player:getCursorTarget()

        if target then
            xi.events.mobHunt.setHuntTarget(target)

            local mobHuntTargetID = GetServerVariable('[MobHunt]Target')
            player:printToPlayer('New Mob Hunt target: ' .. mobHuntTargetID .. '.')
        else
            player:printToPlayer('Invalid target. Please specify a Mob ID or select a target with your cursor.')
        end
    elseif command == 'cleanup' and gmLevel >= 1 then
        local huntTargetID = GetServerVariable('[MobHunt]Target')
        local huntTarget   = huntTargetID > 0 and GetMobByID(huntTargetID)

        if huntTarget then
            xi.events.mobHunt.cleanupHuntTarget(huntTarget)
            player:printToPlayer('Cleaned Mob Hunt Target: ' .. huntTargetID .. '.')
        end
    elseif command == 'get' and gmLevel >= 1 then
        local mobHuntTargetID = GetServerVariable('[MobHunt]Target')
        player:printToPlayer('Current Mob Hunt target: ' .. mobHuntTargetID .. '.')
    elseif command == 'join' then
        xi.events.mobHunt.join(player)
        player:printToPlayer('You have joined the hunt!', xi.msg.channel.SYSTEM_3)
    elseif command == 'quit' then
        xi.events.mobHunt.quit(player)
        player:printToPlayer('You are no longer participating in the hunt.', xi.msg.channel.SYSTEM_3)
    end
end

return commandObj
