-----------------------------------
-- xi.effect.SUBTLE_SORCERY
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

-- Spell Cumulative Enmity reduction handled in magic_state.cpp
effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SUBTLE_SORCERY_EFFECT)

    target:addMod(xi.mod.MACC, 100)
    target:addMod(xi.mod.UFASTCAST, jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SUBTLE_SORCERY_EFFECT)

    target:delMod(xi.mod.MACC, 100)
    target:delMod(xi.mod.UFASTCAST, jpValue)
end

return effectObject
