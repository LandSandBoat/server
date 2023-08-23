-----------------------------------
-- xi.effect.EMBRAVA
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local skill = effect:getPower()
    local regen = math.floor(skill / 7) + 1
    local refresh = math.floor(skill / 100) + 1
    local haste = (math.floor(skill / 20) + 1) * 100

    target:addMod(xi.mod.REGEN, regen)
    target:addMod(xi.mod.REFRESH, refresh)
    target:addMod(xi.mod.HASTE_MAGIC, haste)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local skill = effect:getPower()
    local regen = math.floor(skill / 7) + 1
    local refresh = math.floor(skill / 100) + 1
    local haste = (math.floor(skill / 20) + 1) * 100

    target:delMod(xi.mod.REGEN, regen)
    target:delMod(xi.mod.REFRESH, refresh)
    target:delMod(xi.mod.HASTE_MAGIC, haste)
end

return effectObject
