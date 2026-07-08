-----------------------------------
-- func: injectaction
-- desc: Injects an action packet with the specified action and animation id.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'iiiii'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!injectaction <action ID> <animation ID> (info) (reaction) (message)')
end

commandObj.onTrigger = function(player, actionId, animationId, info, reaction, message)
    -- validate actionId
    if actionId == nil then
        error(player, 'You must provide an action ID.')
        return
    end

    if actionId == 0 or actionId > 15 then
        error(player, '<action ID> is out of range. Current valid and tested action IDs are 1-15.')
        return
    end

    local target = player:getCursorTarget()

    if not target then
        error(player, 'No valid target found')
        return
    end

    -- validate animationId
    if animationId == nil then
        error(player, 'You must provide an animation ID.')
        return
    end

    -- Set default values for optional !injectaction parameters
    if info == nil then
        info = 0
    end

    if reaction == nil then
        reaction = 0
    end

    if message == nil then
        message = 185 -- Default message
    end

    -- inject action packet
    player:injectActionPacket(target:getID(), actionId, animationId, info, reaction, message, 10, 1)
end

return commandObj
