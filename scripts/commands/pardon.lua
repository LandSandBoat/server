-----------------------------------
-- func: pardon
-- desc: Pardons a player from jail. (Mordion Gaol)
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

commandObj.onTrigger = function(player, target)
    if target == nil then
        player:PrintToPlayer('You must enter a valid player name.')
        return
    end

    -- Validate the target..
    local targ = GetPlayerByName(target)
    if targ == nil then
        player:PrintToPlayer(string.format('Invalid player \'%s\' given.', target))
        return
    end

    if targ:getCharVar('inJail') >= 1 then
        local message = string.format('%s is pardoning %s from jail.', player:getName(), targ:getName())
        printf(message)

        targ:setCharVar('inJail', 0)
        targ:warp()
    end
end

return commandObj
