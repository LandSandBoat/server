-----------------------------------
-- tpz.effect.TELEPORT
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local destination = effect:getPower()

    if (target:isMob()) then
        DespawnMob(target:getID())
    elseif (destination == tpz.teleport.id.WARP) then
        target:warp()
    elseif (destination == tpz.teleport.id.ESCAPE) then
        tpz.teleport.escape(target)
    elseif (destination == tpz.teleport.id.OUTPOST) then
        local region = effect:getSubPower()
        tpz.teleport.toOutpost(target, region)
    elseif (destination == tpz.teleport.id.LEADER) then
        tpz.teleport.toLeader(target)
    elseif (destination == tpz.teleport.id.HOME_NATION) then
        tpz.teleport.toHomeNation(target)
    elseif (destination == tpz.teleport.id.RETRACE) then
        tpz.teleport.toAlliedNation(target)
    else
        tpz.teleport.to(target, destination)
    end
end

return effecttbl
