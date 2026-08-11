-----------------------------------
-- xi.effect.SANCTION
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Sanction's experience bonus is region-checked in scripts/globals/experience_points.lua

    local power = effect:getPower()
    if power == 1 then
        target:addLatent(xi.latent.SANCTION_REGEN_BONUS, 95, xi.mod.REGEN, 1)
    elseif power == 2 then
        target:addLatent(xi.latent.SANCTION_REFRESH_BONUS, 75, xi.mod.REFRESH, 1)
    elseif power == 3 then
        -- TODO: Power varies with Imperial defense level
        target:addLatent(xi.latent.SANCTION_FOOD_BONUS, 0, xi.mod.FOOD_DURATION, 100)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    if power == 1 then
        target:delLatent(xi.latent.SANCTION_REGEN_BONUS, 95, xi.mod.REGEN, 1)
    elseif power == 2 then
        target:delLatent(xi.latent.SANCTION_REFRESH_BONUS, 75, xi.mod.REFRESH, 1)
    elseif power == 3 then
        target:delLatent(xi.latent.SANCTION_FOOD_BONUS, 0, xi.mod.FOOD_DURATION, 100)
    end
end

return effectObject
