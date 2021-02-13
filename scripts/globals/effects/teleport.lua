-----------------------------------
-- tpz.effect.TELEPORT
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
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

return effect_object
