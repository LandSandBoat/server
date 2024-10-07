-----------------------------------
-- xi.effect.COMPOSURE
-- Increases accuracy and lengthens recast time. Enhancement effects gained through white
-- and black magic you cast on yourself last longer.
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local player = target:getMaster() or target
    local mLevel = player:getMainLvl()
    local jpValue = player:getJobPointLevel(xi.jp.COMPOSURE_EFFECT)
    local accPower = math.floor(((24 * mLevel) + 74) / 49)
    effect:setPower(accPower + jpValue)

    player:addMod(xi.mod.ACC, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- Recalculate accuracy every tick in case of level change
    local player = target:getMaster() or target
    local mLevel = player:getMainLvl()
    local jpValue = player:getJobPointLevel(xi.jp.COMPOSURE_EFFECT)
    local newAccPower = math.floor(((24 * mLevel) + 74) / 49)
    local newPower = newAccPower + jpValue

    if newPower ~= effect:getPower() then
        player:delMod(xi.mod.ACC, effect:getPower())  -- Remove old bonus
        effect:setPower(newPower)                     -- Update stored power
        player:addMod(xi.mod.ACC, newPower)           -- Apply new bonus
    end
end

effectObject.onEffectLose = function(target, effect)
    local player = target:getMaster() or target

    player:delMod(xi.mod.ACC, effect:getPower())
end

return effectObject
