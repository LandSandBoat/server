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
        effectArg:setMod(xi.mod.ATT, 2 * mainPower)
        effectArg:setMod(xi.mod.CRITHITRATE, mainPower)

        -- Handle Critical Hit Damage & Accuracy bonuses
        local subPower = effectArg:getSubPower() -- Subpower tracks if user had effect augment, and what quality, when effect was applied.
        if subPower ~= 0 then
            effectArg:setMod(xi.mod.ACC, 2 * mainPower)
            effectArg:setMod(xi.mod.CRIT_DMG_INCREASE, math.floor(subPower / 2) * mainPower)
        end
    end)

    target:addListener('MELEE_SWING_MISS', 'IMPETUS_MISS', function(actorArg, targetArg, attack)
        local effectArg = actorArg:getStatusEffect(xi.effect.IMPETUS)
        if not effectArg then
            return
        end

        effectArg:setPower(0)

        effectArg:setMod(xi.mod.ATT, 0)
        effectArg:setMod(xi.mod.CRITHITRATE, 0)
        effectArg:setMod(xi.mod.ACC, 0)
        effectArg:setMod(xi.mod.CRIT_DMG_INCREASE, 0)
    end)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:removeListener('IMPETUS_MISS')
    target:removeListener('IMPETUS_HIT')
end

return effectObject
