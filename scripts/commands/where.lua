-----------------------------------
-- func: where
-- desc: Tells the player about their current position.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    player:showPosition()
end

return commandObj
