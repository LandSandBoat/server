-----------------------------------
-- xi.effect.DODGE
-----------------------------------
---@type TEffect
local effectObject = {}

-- TODO: implement Glanzfaust effects
effectObject.onEffectGain = function(target, effect)
    local jpLevel   = target:getJobPointLevel(xi.jp.DODGE_EFFECT)
    local dodgeMod  = target:getMod(xi.mod.DODGE_EFFECT)
    local monkLevel = utils.getActiveJobLevel(target, xi.job.MNK)

    -- https://www.bg-wiki.com/ffxi/Dodge
    effect:addMod(xi.mod.EVA, monkLevel + 1 + dodgeMod + jpLevel)
    effect:addMod(xi.mod.ADDITIVE_GUARD, math.floor((monkLevel + 1) * 0.2))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
