-----------------------------------
-- func: getid
-- desc: Prints the ID of the currently selected target under the cursor
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local targ = player:getCursorTarget()
    if targ ~= nil then
        player:PrintToPlayer(string.format('%s\'s ID is: %u ', targ:getName(), targ:getID()))
    else
        player:PrintToPlayer('Must select a target using in game cursor first.')
    end
end

return commandObj
