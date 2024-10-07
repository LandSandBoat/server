-----------------------------------
-- xi.effect.COMPOSURE
-- Increases accuracy and lengthens recast time. Enhancement effects gained through white
-- and black magic you cast on yourself last longer.
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.COMPOSURE_EFFECT)
    local cLevel = target:getMainLevel()
    local accPower = math.floor(((24 * cLevel) + 74) / 49)

    target:addMod(xi.mod.ACC, accPower + jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.COMPOSURE_EFFECT)
    local cLevel = target:getMainLevel()
    local accPower = math.floor(((24 * cLevel) + 74) / 49)

    target:delMod(xi.mod.ACC, accPower + jpValue)
end

return effectObject
