-----------------------------------
-- func: cansee <target>
-- desc: Can you see (via ximesh raycasting) your cursor target?
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

commandObj.onTrigger = function(player, ignoreInvisibleBoundaries)
    local target = player:getCursorTarget()
    if not target then
        player:printToPlayer('No cursor target provided')
        return
    end

    local str = player:canSee(target, ignoreInvisibleBoundaries == 1) and 'CAN' or 'CANNOT'
    player:printToPlayer(string.format('%s %s see %s', player:getName(), str, target:getName()))
end

return commandObj
