-----------------------------------
-- xi.effect.MINUET
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATT, effect:getPower())
    target:addMod(xi.mod.RATT, effect:getPower())
    target:addMod(xi.mod.STR, effect:getSubPower()) -- Apply Stat Buff from AUGMENT_SONG_STAT
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, effect:getPower())
    target:delMod(xi.mod.RATT, effect:getPower())
    target:delMod(xi.mod.STR, effect:getSubPower()) -- Remove Stat Buff from AUGMENT_SONG_STAT
end

return effectObject
