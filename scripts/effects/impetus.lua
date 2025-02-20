-----------------------------------
-- xi.effect.IMPETUS
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addListener('MELEE_SWING_MISS', 'IMPETUS_MISS', xi.job_utils.monk.impetusMissListener)
    target:addListener('MELEE_SWING_HIT', 'IMPETUS_HIT', xi.job_utils.monk.impetusHitListener)

    -- For reload from the DB (/logout, login), add the effect power
    local mainPower = effect:getPower()    -- Stores Attack & Critical Hit Rate bonuses
    local subPower  = effect:getSubPower() -- Stores Critical Hit Damage & Accuracy bonuses

    if mainPower > 0 then
        target:addMod(xi.mod.ATT, mainPower * 2)
        target:addMod(xi.mod.CRITHITRATE, mainPower)
    end

    if subPower > 0 then
        target:addMod(xi.mod.ACC, subPower * 2)
        target:addMod(xi.mod.CRIT_DMG_INCREASE, subPower)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:removeListener('MELEE_SWING_MISS')
    target:removeListener('MELEE_SWING_HIT')

    -- TODO: Support Tantra Cyclas + 1 (does not give critical hit damage)
    local mainPower = effect:getPower()    -- Stores Attack & Critical Hit Rate bonuses
    local subPower  = effect:getSubPower() -- Stores Critical Hit Damage & Accuracy bonuses

    if mainPower > 0 then
        target:delMod(xi.mod.ATT, mainPower * 2)
        target:delMod(xi.mod.CRITHITRATE, mainPower)
    end

    if subPower > 0 then
        target:delMod(xi.mod.ACC, subPower * 2)
        target:delMod(xi.mod.CRIT_DMG_INCREASE, subPower)
    end
end

return effectObject
