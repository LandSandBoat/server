-----------------------------------
-- xi.effect.HAGAKURE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SAVETP, 400)
    target:addMod(xi.mod.TP_BONUS, 1000)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SAVETP, 400)
    target:delMod(xi.mod.TP_BONUS, 1000)
end

return effect_object
