-----------------------------------
-- tpz.effect.MAGIC_DEF_BOOST
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if (effect:getPower()>100) then
        effect:setPower(50)
    end
    target:addMod(tpz.mod.MDEF, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MDEF, effect:getPower())
end

return effect_object
