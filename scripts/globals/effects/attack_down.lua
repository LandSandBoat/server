-----------------------------------
-- tpz.effect.ATTACK_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if (effect:getPower()>100) then
        effect:setPower(50)
    end
    target:addMod(tpz.mod.ATTP, -effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ATTP, -effect:getPower())
end

return effect_object
