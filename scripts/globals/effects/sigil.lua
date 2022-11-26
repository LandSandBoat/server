-----------------------------------
-- xi.effect.SIGIL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

-- TODO: Find a way to simplify this.  Is this a bitfield?
effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower() -- Tracks which bonus effects are in use.

    if
        power == 1 or
        power == 3 or
        power == 5 or
        power == 7 or
        power == 9 or
        power == 11 or
        power == 13 or
        power == 15
    then
        local percentage = 70 -- TODO: This should be based off of controlled areas in Campaign
        target:addLatent(xi.latent.SIGIL_REGEN_BONUS, percentage, xi.mod.REGEN, 1)
    end

    if
        power == 2 or
        power == 3 or
        power == 6 or
        power == 7 or
        power == 10 or
        power == 11 or
        power >= 14
    then
        local percentage = 60 -- TODO: This should be based off of controlled areas in Campaign
        target:addLatent(xi.latent.SIGIL_REFRESH_BONUS, percentage, xi.mod.REFRESH, 1)
    end

    if
        power >= 4 and
        power <= 7
    then
        target:addMod(xi.mod.FOOD_DURATION, 100)
    elseif
        power >= 8 and
        power <= 11
    then
        -- target:addMod(xi.mod.EXPLOSS_REDUCTION), ???)
        -- exp loss reduction not implemented.
    elseif power >= 12 then
        -- Possibly handle exp loss reduction in core instead..Maybe the food bonus also?
        target:addMod(xi.mod.FOOD_DURATION, 100)
        -- target:addLatent(LATENT_SIGIL_EXPLOSS, ?, MOD_EXPLOSS_REDUCTION, ?)
        -- exp loss reduction not implemented.
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower() -- Tracks which bonus effects are in use.
    -- local subPower = effect:getSubPower() -- subPower sets % required to trigger regen/refresh.

    if
        power == 1 or
        power == 3 or
        power == 5 or
        power == 7 or
        power == 9 or
        power == 11 or
        power == 13 or
        power == 15
    then
        local percentage = 70 -- TODO: This should be based off of controlled areas in Campaign
        target:delLatent(xi.latent.SIGIL_REGEN_BONUS, percentage, xi.mod.REGEN, 1)
    end

    if
        power == 2 or
        power == 3 or
        power == 6 or
        power == 7 or
        power == 10 or
        power == 11 or
        power >= 14
    then
        local percentage = 60 -- TODO: This should be based off of controlled areas in Campaign
        target:delLatent(xi.latent.SIGIL_REFRESH_BONUS, percentage, xi.mod.REFRESH, 1)
    end

    if
        effect:getPower() >= 4 and
        effect:getPower() <= 7
    then
        target:delMod(xi.mod.FOOD_DURATION, 100)
    elseif
        effect:getPower() >= 8 and
        effect:getPower() <= 11
    then
        -- target:delMod(xi.mod.EXPLOSS_REDUCTION), ???)
        -- exp loss reduction not implemented.
    elseif effect:getPower() >= 12 then
        target:delMod(xi.mod.FOOD_DURATION, 100)
        -- target:delMod(xi.mod.EXPLOSS_REDUCTION), ???)
        -- exp loss reduction not implemented.
    end
end

return effectObject
