-----------------------------------
-- xi.effect.FOCUS
-- Note: Glanzfaust bonus is implemented as a latent effect while wearing the equipment and having the effect
-----------------------------------
---@type TEffect
local effectObject = {}

-- TODO: implement focus ranged accuracy bonus (needs verification)
effectObject.onEffectGain = function(target, effect)
    local bonusPower = effect:getPower()
    local monkLevel = utils.getActiveJobLevel(target, xi.job.MNK) + 1

    -- https://wiki.ffo.jp/html/2841.html
    effect:addMod(xi.mod.ACC, monkLevel + bonusPower)

    -- https://www.bg-wiki.com/ffxi/Focus
    effect:addMod(xi.mod.CRITHITRATE, math.floor(monkLevel * 0.2))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
