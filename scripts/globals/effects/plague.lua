-----------------------------------
-- tpz.effect.PLAGUE
-- Plague is a harmful status effect that reduces a character's TP and MP over time.
-- Also, causes Steps to only grant One Finishing Move when Main Job is Dancer.
-- Normal power is 5.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.REFRESH_DOWN, math.ceil(effect:getPower() / 2))
    target:addMod(tpz.mod.REGAIN_DOWN, effect:getPower()*10)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.REFRESH_DOWN, math.ceil(effect:getPower() / 2))
    target:delMod(tpz.mod.REGAIN_DOWN, effect:getPower()*10)
end

return effect_object
