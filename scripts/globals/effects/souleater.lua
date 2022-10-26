-----------------------------------
-- xi.effect.SOULEATER
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Enmity bonus is handled in the CalculateEnmityBonus function inside enmity_container.cpp
    local subPower = effect:getSubPower()

    target:addMod(xi.mod.ACC, 25)
    target:addMod(xi.mod.ZANSHIN, subPower)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local subPower = effect:getSubPower()

    target:delMod(xi.mod.ACC, 25)
    target:delMod(xi.mod.ZANSHIN, subPower)
end

return effectObject
