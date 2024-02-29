-----------------------------------
-- xi.effect.SIGIL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower() -- Tracks which bonus effects are in use.

    if utils.mask.getBit(power, 1) then
        local percentage = 70 -- TODO: This should be based off of controlled areas in Campaign
        target:addLatent(xi.latent.SIGIL_REGEN_BONUS, percentage, xi.mod.REGEN, 1)
    end

    if utils.mask.getBit(power, 2) then
        local percentage = 60 -- TODO: This should be based off of controlled areas in Campaign
        target:addLatent(xi.latent.SIGIL_REFRESH_BONUS, percentage, xi.mod.REFRESH, 1)
    end

    if utils.mask.getBit(power, 3) then
        target:addMod(xi.mod.FOOD_DURATION, 100)
    end

    if utils.mask.getBit(power, 4) then
        -- target:addMod(xi.mod.EXPLOSS_REDUCTION), ???)
        -- exp loss reduction not implemented.
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower() -- Tracks which bonus effects are in use.
    -- local subPower = effect:getSubPower() -- subPower sets % required to trigger regen/refresh.

    if utils.mask.getBit(power, 1) then
        local percentage = 70 -- TODO: This should be based off of controlled areas in Campaign
        target:delLatent(xi.latent.SIGIL_REGEN_BONUS, percentage, xi.mod.REGEN, 1)
    end

    if utils.mask.getBit(power, 2) then
        local percentage = 60 -- TODO: This should be based off of controlled areas in Campaign
        target:delLatent(xi.latent.SIGIL_REFRESH_BONUS, percentage, xi.mod.REFRESH, 1)
    end

    if utils.mask.getBit(power, 3) then
        target:delMod(xi.mod.FOOD_DURATION, 100)
    end

    if utils.mask.getBit(power, 4) then
        -- target:delMod(xi.mod.EXPLOSS_REDUCTION), ???)
        -- exp loss reduction not implemented.
    end
end

return effectObject
