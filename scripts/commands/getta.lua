-----------------------------------
-- func: getta
-- desc: returns the name of the entity that would be chosen for trick attack given the current (mob) target
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

-- function onTrigger(player, extendedMode)
commandObj.onTrigger = function(player)
    local targ = player:getCursorTarget()
    if targ ~= nil then
        local tatarget = player:getTrickAttackChar(targ)
        if tatarget ~= nil then
            player:PrintToPlayer(string.format('Trick attack would select: %s', tatarget:getName()))
        else
            player:PrintToPlayer('No valid TA target found.')
        end
    else
        player:PrintToPlayer('Must select a target using in game cursor first.')
    end
end

return commandObj
