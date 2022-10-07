-----------------------------------
-- xi.effect.SANCTION
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- target:addLatent(xi.latent.SANCTION_EXP, ?, xi.mod.EXP_BONUS, ?)
    -- Possibly handle exp bonus in core instead

    local power = effect:getPower()
    if power == 1 then
        target:addLatent(xi.latent.SANCTION_REGEN_BONUS, 95, xi.mod.REGEN, 1)
    elseif power == 2 then
        target:addLatent(xi.latent.SANCTION_REFRESH_BONUS, 75, xi.mod.REFRESH, 1)
    elseif power == 3 then
        target:addMod(xi.mod.FOOD_DURATION, 100)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    -- target:delLatent(xi.latent.SANCTION_EXP, ?, xi.mod.EXP_BONUS, ?)

    local power = effect:getPower()
    if power == 1 then
        target:delLatent(xi.latent.SANCTION_REGEN_BONUS, 95, xi.mod.REGEN, 1)
    elseif power == 2 then
        target:delLatent(xi.latent.SANCTION_REFRESH_BONUS, 75, xi.mod.REFRESH, 1)
    elseif power == 3 then
        target:delMod(xi.mod.FOOD_DURATION, 100)
    end
end

return effectObject
