-----------------------------------
-- xi.effect.FOOTWORK
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.KICK_ATTACK_RATE, 20)
    target:addMod(xi.mod.KICK_DMG, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.KICK_ATTACK_RATE, 20)
    target:delMod(xi.mod.KICK_DMG, effect:getPower())
end

return effect_object
