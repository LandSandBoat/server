-----------------------------------
-- xi.effect.BERSERK
-----------------------------------
require("scripts/globals/jobpoints")
-----------------------------------
local effectObject = {}

-- DEFP penalty reduction from Warrior's Calligae NQ/+1/+2 handled by latent effect
-- CRITHITRATE & DOUBLE_ATTACK bonuses from Conqueror (all forms) handled by latent effect
effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    local jpLevel = target:getJobPointLevel(xi.jp.BERSERK_EFFECT)
    local jpEffect = jpLevel * 2

    target:addMod(xi.mod.ATTP, power)
    target:addMod(xi.mod.RATTP, power)
    target:addMod(xi.mod.DEFP, -power)

    -- Job Point Bonuses
    target:addMod(xi.mod.ATT, jpEffect)
    target:addMod(xi.mod.RATT, jpEffect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    local jpLevel = target:getJobPointLevel(xi.jp.BERSERK_EFFECT)
    local jpEffect = jpLevel * 2

    target:delMod(xi.mod.ATTP, power)
    target:delMod(xi.mod.RATTP, power)
    target:delMod(xi.mod.DEFP, -power)

    -- Job Point Bonuses
    target:delMod(xi.mod.ATT, jpEffect)
    target:delMod(xi.mod.RATT, jpEffect)
end

return effectObject
