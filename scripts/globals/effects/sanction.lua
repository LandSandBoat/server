-----------------------------------
-- tpz.effect.SANCTION
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    -- target:addLatent(tpz.latent.SANCTION_EXP, ?, tpz.mod.EXP_BONUS, ?)
    -- Possibly handle exp bonus in core instead

    local power = effect:getPower()
    if power == 1 then
        target:addLatent(tpz.latent.SANCTION_REGEN_BONUS, 95, tpz.mod.REGEN, 1)
    elseif power == 2 then
        target:addLatent(tpz.latent.SANCTION_REFRESH_BONUS, 75, tpz.mod.REFRESH, 1)
    elseif power == 3 then
        target:addMod(tpz.mod.FOOD_DURATION, 100)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    -- target:delLatent(tpz.latent.SANCTION_EXP, ?, tpz.mod.EXP_BONUS, ?)

    local power = effect:getPower()
    if power == 1 then
        target:delLatent(tpz.latent.SANCTION_REGEN_BONUS, 95, tpz.mod.REGEN, 1)
    elseif power == 2 then
        target:delLatent(tpz.latent.SANCTION_REFRESH_BONUS, 75, tpz.mod.REFRESH, 1)
    elseif power == 3 then
        target:delMod(tpz.mod.FOOD_DURATION, 100)
    end
end

return effect_object
