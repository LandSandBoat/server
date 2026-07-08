-----------------------------------
-- xi.effect.IMPETUS
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addListener('MELEE_SWING_HIT', 'IMPETUS_HIT', function(actorArg, targetArg, attack)
        local effectArg = actorArg:getStatusEffect(xi.effect.IMPETUS)
        if not effectArg then
            return
        end

        local mainPower = effectArg:getPower() + 1 -- Tracks stacks.
        if mainPower > 50 then
            return
        end

        -- Handle Attack & Critical Hit Rate bonuses
        effectArg:setPower(mainPower)
        effectArg:addMod(xi.mod.ATT, 2)
        effectArg:addMod(xi.mod.CRITHITRATE, 1)

        -- Handle Critical Hit Damage & Accuracy bonuses
        local subPower = effectArg:getSubPower() -- Subpower tracks if user had effect augment, and what quality, when effect was applied.
        if subPower ~= 0 then
            effectArg:addMod(xi.mod.ACC, 2)
            effectArg:addMod(xi.mod.CRIT_DMG_INCREASE, math.floor(subPower / 2))
        end
    end)

    target:addListener('MELEE_SWING_MISS', 'IMPETUS_MISS', function(actorArg, targetArg, attack)
        local effectArg = actorArg:getStatusEffect(xi.effect.IMPETUS)
        if not effectArg then
            return
        end

        local power = effectArg:getPower()
        effectArg:setPower(0)
        effectArg:delMod(xi.mod.ATT, 2 * power)
        effectArg:delMod(xi.mod.CRITHITRATE, power)

        local subPower = effectArg:getSubPower() -- Subpower tracks if user had effect augment, and what quality, when effect was applied.
        if subPower ~= 0 then
            effectArg:delMod(xi.mod.ACC, 2 * power)
            effectArg:delMod(xi.mod.CRIT_DMG_INCREASE, math.floor(subPower / 2) * power)
        end
    end)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:removeListener('IMPETUS_MISS')
    target:removeListener('IMPETUS_HIT')
end

return effectObject
