-----------------------------------
-- xi.effect.ACCURACY_BOOST
--
-- getPower     = ACC
-- getSubPower  = RACC
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, effect:getPower())
    if effect:getSubPower() > 0 then
        target:addMod(xi.mod.RACC, effect:getSubPower())
    end
end

effectObject.onEffectTick = function(target, effect)
    -- the effect loses accuracy of 1 every 3 ticks depending on the source of the acc boost
    local boostACCEffectSize = effect:getPower()
    if boostACCEffectSize > 0 then
        effect:setPower(boostACCEffectSize - 1)
        target:delMod(xi.mod.ACC, 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local boostACCEffectSize = effect:getPower()
    if boostACCEffectSize > 0 then
        target:delMod(xi.mod.ACC, effect:getPower())
    end

    if effect:getSubPower() > 0 then
        target:delMod(xi.mod.RACC, effect:getSubPower())
    end
end

return effectObject
