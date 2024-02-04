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
        local tatarget    = player:getTrickAttackChar(targ)
        local trickAttack = player:getStatusEffect(xi.effect.TRICK_ATTACK)

        if not trickAttack then
            player:printToPlayer('You do not have Trick Attack active, !getta will fail.')
        elseif tatarget ~= nil then
            player:printToPlayer(string.format('Trick attack would select: %s', tatarget:getName()))
        else
            player:printToPlayer('No valid TA target found.')
        end
    else
        player:printToPlayer('Must select a target using in game cursor first.')
    end
end

return commandObj
