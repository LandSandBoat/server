-----------------------------------
-- xi.effect.FOIL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.SPECIAL_ATTACK_EVASION, effect:getPower())
end

effect_object.onEffectTick = function(target, effect) -- TODO: Determine how Foil ticks down? It's description indicates this.
end

effect_object.onEffectLose = function(target, effect)
    -- intentionally blank. mod removes itself in C++ due to being added to the effect.
end

return effect_object
