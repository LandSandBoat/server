-----------------------------------
-- tpz.effect.FOOTWORK
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.KICK_ATTACK_RATE, 20)
    target:addMod(tpz.mod.KICK_DMG, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.KICK_ATTACK_RATE, 20)
    target:delMod(tpz.mod.KICK_DMG, effect:getPower())
end

return effect_object
