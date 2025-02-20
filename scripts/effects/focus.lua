-----------------------------------
-- xi.effect.FOCUS
-----------------------------------
---@type TEffect
local effectObject = {}

-- TODO: implement Glanzfaust effects
-- TODO: implement focus ranged accuracy bonus (needs verification)
effectObject.onEffectGain = function(target, effect)
    local jpLevel   = target:getJobPointLevel(xi.jp.FOCUS_EFFECT)
    local focusMod  = target:getMod(xi.mod.FOCUS_EFFECT)
    local monkLevel = utils.getActiveJobLevel(target, xi.job.MNK)

    -- https://wiki.ffo.jp/html/2841.html
    effect:addMod(xi.mod.ACC, monkLevel + 1 + focusMod + jpLevel)

    -- https://www.bg-wiki.com/ffxi/Focus
    effect:addMod(xi.mod.CRITHITRATE, math.floor((monkLevel + 1) * .2))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
