-----------------------------------
-- xi.effect.ACCURACY_BOOST
--
-- getPower     = ACC
-- getSubPower  = RACC
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, effect:getPower())
    if effect:getSubPower() > 0 then
        target:addMod(xi.mod.RACC, effect:getSubPower())
    end
end

effect_object.onEffectTick = function(target, effect)
    -- the effect loses accuracy of 1 every 3 ticks depending on the source of the acc boost
    local boostACC_effect_size = effect:getPower()
    if (boostACC_effect_size > 0) then
        effect:setPower(boostACC_effect_size - 1)
        target:delMod(xi.mod.ACC, 1)
    end
end

effect_object.onEffectLose = function(target, effect)
    local boostACC_effect_size = effect:getPower()
    if (boostACC_effect_size > 0) then
        target:delMod(xi.mod.ACC, effect:getPower())
    end
    if effect:getSubPower() > 0 then
        target:delMod(xi.mod.RACC, effect:getSubPower())
    end
end

return effect_object
