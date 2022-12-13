-----------------------------------
-- xi.effect.HUNDRED_FISTS
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.HUNDRED_FISTS_EFFECT)
    target:addMod(xi.mod.ACC, jpLevel * 2)
    -- Mobs do not TP or cast while hundred fists is active
    if target:isMob() then
        target:setMobAbilityEnabled(false)
        target:setMagicCastingEnabled(false)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.HUNDRED_FISTS_EFFECT)
    target:delMod(xi.mod.ACC, jpLevel * 2)
    if target:isMob() then
        target:setMobAbilityEnabled(true)
        target:setMagicCastingEnabled(true)
    end
end

return effectObject
