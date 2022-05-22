-----------------------------------
-- xi.effect.EMBOLDEN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

-- these functions are intentionally blank. See scritps/globals/spells/spell_enhancing.lua
effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
end

return effect_object
