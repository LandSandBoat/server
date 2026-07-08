-----------------------------------
-- xi.effect.LAST_RESORT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local targetMerit     = target:getMerit(xi.merit.LAST_RESORT_EFFECT)
    local targetJobPoints = target:getJobPointLevel(xi.jp.LAST_RESORT_EFFECT)

    -- Job point effect
    effect:addMod(xi.mod.ATT, 2 * targetJobPoints)
    effect:addMod(xi.mod.RATT, 2 * targetJobPoints)

    -- Merit effect
    effect:addMod(xi.mod.ATTP, 25 + targetMerit)
    effect:addMod(xi.mod.RATTP, 25 + targetMerit)
    effect:addMod(xi.mod.DEFP, -25 - targetMerit)

    effect:addMod(xi.mod.TWOHAND_HASTE_ABILITY, target:getMod(xi.mod.DESPERATE_BLOWS) + target:getMerit(xi.merit.DESPERATE_BLOWS))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
