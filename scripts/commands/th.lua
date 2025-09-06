---------------------------------------------------------------------------------------------------
-- func: th
-- desc: Prints the TH Value of the currently selected target under the cursor
---------------------------------------------------------------------------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = ""
}

commandObj.onTrigger = function(player)
    local target = player:getCursorTarget()
    if (target ~= nil) and (target:isMob()) then
        player:printToPlayer(string.format("%s's current TH level is: %i ", target:getName(), target:getTHlevel()))
    else
        player:printToPlayer("Must select a target using in game cursor first.")
    end
end

return commandObj
