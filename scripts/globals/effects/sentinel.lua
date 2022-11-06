-----------------------------------
-- xi.effect.SENTINEL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local enmityBonus = 100

    if target:getMainJob() ~= xi.job.PLD then
        enmityBonus = 50
    end

    target:addMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:addMod(xi.mod.ENMITY, enmityBonus)
    target:addMod(xi.mod.ENMITY_LOSS_REDUCTION, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
    local power = effect:getPower()
    local decayby = 0

    -- Damage reduction decays until 50% then stops
    if power > 5000 then
        -- final tick with feet just has to be odd.
        if power == 5500 then
            decayby = 500
            -- decay by 8% per tick
        else
            decayby = 800
        end

        effect:setPower(power - decayby)
        target:delMod(xi.mod.UDMGPHYS, -decayby)
    end
end

effectObject.onEffectLose = function(target, effect)
    local enmityBonus = 100

    if target:getMainJob() ~= xi.job.PLD then
        enmityBonus = 50
    end

    target:delMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:delMod(xi.mod.ENMITY, enmityBonus)
    target:delMod(xi.mod.ENMITY_LOSS_REDUCTION, effect:getSubPower())
end

return effectObject
