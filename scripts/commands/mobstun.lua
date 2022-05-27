---------------------------------------------------------------------------------------------------
-- func: mobstun
-- desc: stuns a mob for an hour. good for testing damage/mechanics on a punching bag.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 3,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    if targ ~= nil and targ:isMob() then
        local stun = targ:getStatusEffect(tpz.effect.STUN)
        targ:delStatusEffect(tpz.effect.STUN)
        if stun == nil or stun:getPower() ~= 69 then -- it's toggleable
            targ:addStatusEffect(tpz.effect.STUN, 69, 0, 3600)
            player:PrintToPlayer("Gave target mob super Stun.")
        else
            player:PrintToPlayer("Removed target mob's super Stun.")
        end
    else
        player:PrintToPlayer("Must select a target monster using in game cursor first.")
    end
end
