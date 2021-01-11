----------------------------------------
-- tpz.effect.CLARION_CALL
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MAXIMUM_SONGS_BONUS, 1)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MAXIMUM_SONGS_BONUS, 1)
end

return effect_object
