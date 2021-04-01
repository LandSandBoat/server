-----------------------------------
-- xi.effect.SEIGAN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.COUNTER, (target:getMod(xi.mod.ZANSHIN)/4))
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.COUNTER, (target:getMod(xi.mod.ZANSHIN)/4))
end

return effect_object
