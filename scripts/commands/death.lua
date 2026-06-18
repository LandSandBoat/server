-----------------------------------
-- func: !death
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

commandObj.onTrigger = function(player)
    player:injectActionPacket(player:getID(), 5, 270, 0, 0, 0, 10, 1)
end

return commandObj
