-----------------------------------
-- xi.effect.BIO
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:addMod(xi.mod.ATTP, -subpower)
    target:addMod(xi.mod.REGEN_DOWN, power)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:delMod(xi.mod.ATTP, -subpower)
    target:delMod(xi.mod.REGEN_DOWN, power)
end

return effect_object
