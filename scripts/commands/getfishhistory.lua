-----------------------------------
-- func: getFishHistory
-- desc: Prints the history stats of a given player
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if target ~= nil then
        targ = GetPlayerByName(target)
    else
        targ = player:getCursorTarget()
    end

    if targ == nil then
        if target ~= nil then
            player:printToPlayer(string.format('Player named %s not found!', target))
            return
        else
            player:printToPlayer('Find a target, either by name or cursor!')
            return
        end
    elseif not targ:isPC() then
        player:printToPlayer('Target is not a player!')
        return
    end

    if targ == nil then
        return
    end

    if targ:getFishingStats() == nil then
        player:printToPlayer('Unable to retrieve stats from target!')
        return
    end

    local fishStats = targ:getFishingStats() or {}
    player:printToPlayer(string.format('Showing Fishing Stats for: %s', targ:getName() or 'Unknown'), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Lines Cast: %s', fishStats['fishLinesCast'] or 0), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Fish Caught: %s', fishStats['fishReeled'] or 0), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Biggest Fish: %s ilms (%s)', fishStats['fishLongestLength'] or 0, fishStats['fishLongestId'] or 0), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Heaviest Fish: %s ponzes (%s)', fishStats['fishHeaviestWeight'] or 0, fishStats['fishHeaviestId'] or 0), xi.msg.channel.SYSTEM_3)
end

return commandObj
