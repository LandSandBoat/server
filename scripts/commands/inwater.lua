-----------------------------------
-- func: inwater <target>
-- desc: Are you in water?
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    player:printToPlayer(player:inWater() and 'You are in water' or 'You are on land')
end

return commandObj
