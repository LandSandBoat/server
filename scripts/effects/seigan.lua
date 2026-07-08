-----------------------------------
-- xi.effect.SEIGAN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- TODO: confirm if this def bonus is only active with 2hander equipped and either follow the pattern currently in hasso/desperate blows or consider a latent sytle effect
    local jpValue = target:getJobPointLevel(xi.jp.SEIGAN_EFFECT)

    effect:addMod(xi.mod.DEF, jpValue * 3)

    -- SAM main job bonus: Seigan gives counter chance at 25% of Zanshin rate
    if target:getMainJob() == xi.job.SAM then
        effect:addMod(xi.mod.SEIGAN_COUNTER_BONUS, 1)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
