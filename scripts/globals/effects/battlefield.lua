-----------------------------------
-- xi.effect.BATTLEFIELD
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if target:getPet() then
        target:getPet():addStatusEffect(effect)
    end

    if target:getObjType() == xi.objType.PC then
        target:clearTrusts()
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if pet then
        pet:delStatusEffect(xi.effect.BATTLEFIELD)
        pet:leaveBattlefield(1)
    end
    target:setLocalVar("[battlefield]area", 0)
end

return effect_object
