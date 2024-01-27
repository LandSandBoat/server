-----------------------------------
-- func: stun
-- desc: stuns a non-NPC target for an hour. good for testing damage/mechanics on a punching bag.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 3,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local targ = player:getCursorTarget()
    if targ and not targ:isNPC() then
        local stun = targ:getStatusEffect(xi.effect.STUN)
        targ:delStatusEffect(xi.effect.STUN)
        if not stun or stun:getPower() ~= 69 then -- it's toggleable
            targ:addStatusEffect(xi.effect.STUN, 69, 0, 3600)
            player:printToPlayer('Gave target super Stun.')
        else
            player:printToPlayer('Removed target mob\'s super Stun.')
        end
    else
        player:printToPlayer('Must select a non-NPC target using in game cursor first.')
    end
end

return commandObj
