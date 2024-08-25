-----------------------------------
-- xi.effect.LAST_RESORT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ATT, 2 * target:getJobPointLevel(xi.jp.LAST_RESORT_EFFECT))
    effect:addMod(xi.mod.ATTP, 25 + target:getMerit(xi.merit.LAST_RESORT_EFFECT))
    effect:addMod(xi.mod.TWOHAND_HASTE_ABILITY, target:getMod(xi.mod.DESPERATE_BLOWS) + target:getMerit(xi.merit.DESPERATE_BLOWS))
    effect:addMod(xi.mod.DEFP, -25 - target:getMerit(xi.merit.LAST_RESORT_EFFECT))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
