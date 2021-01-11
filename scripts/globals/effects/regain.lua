-----------------------------------
-- tpz.effect.REGAIN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.REGAIN, effect:getPower() * 10)
end

effect_object.onEffectTick = function(target, effect)

end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.REGAIN, effect:getPower() * 10)
end

return effect_object
