-----------------------------------
-- xi.effect.CHAINSPELL
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CHAINSPELL_EFFECT)

    target:addMod(xi.mod.UFASTCAST, 150)
    target:addMod(xi.mod.MAGIC_DAMAGE, jpValue * 2)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CHAINSPELL_EFFECT)

    target:delMod(xi.mod.UFASTCAST, 150)
    target:delMod(xi.mod.MAGIC_DAMAGE, jpValue * 2)
end

return effect_object
