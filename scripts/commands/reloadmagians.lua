-----------------------------------
-- func: reloadmagians
-- desc: Reloads the magian listeners
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = 'b'
}

commandObj.onTrigger = function(player)
    xi.magian.registerTrialListeners()
    player:printToPlayer('Magian trials re-registered!')
end

return commandObj
