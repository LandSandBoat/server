-----------------------------------
-- xi.effect.LAST_RESORT
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.LAST_RESORT_EFFECT)

    target:addMod(xi.mod.ATT, 2 * jpValue)
    target:addMod(xi.mod.ATTP, 25 + target:getMerit(xi.merit.LAST_RESORT_EFFECT))
    target:addMod(xi.mod.HASTE_ABILITY, target:getMod(xi.mod.DESPERATE_BLOWS) + target:getMerit(xi.merit.DESPERATE_BLOWS))

    -- Gear that affects this mod is handled by a Latent Effect because the gear must remain equipped
    target:addMod(xi.mod.DEFP, -25 - target:getMerit(xi.merit.LAST_RESORT_EFFECT))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.LAST_RESORT_EFFECT)

    target:delMod(xi.mod.ATT, 2 * jpValue)
    target:delMod(xi.mod.ATTP, 25 + target:getMerit(xi.merit.LAST_RESORT_EFFECT))
    target:delMod(xi.mod.HASTE_ABILITY, target:getMod(xi.mod.DESPERATE_BLOWS) + target:getMerit(xi.merit.DESPERATE_BLOWS))
    -- Gear that affects this mod is handled by a Latent Effect because the gear must remain equipped
    target:delMod(xi.mod.DEFP, -25 - target:getMerit(xi.merit.LAST_RESORT_EFFECT))
end

return effectObject
