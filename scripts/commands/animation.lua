-----------------------------------
-- func: animation
-- desc: Sets the players current animation.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!animation (animationID)')
end

commandObj.onTrigger = function(player, animationId)
    local oldAnimation = player:getAnimation()

    if animationId == nil then
        player:printToPlayer(string.format('Current player animation: %d', oldAnimation))
        return
    end

    -- validate animationId
    animationId = tonumber(animationId) or xi.anim[string.upper(animationId)]
    if animationId == nil or animationId < 0 then
        error(player, 'Invalid animationId.')
        return
    end

    -- set player animation
    player:setAnimation(animationId)
    player:printToPlayer(string.format('%s | Old animation: %i | New animation: %i\n', player:getName(), oldAnimation, animationId))
end

return commandObj
