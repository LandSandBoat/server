-----------------------------------
-- tpz.effect.EMBRAVA
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local skill = effect:getPower()
    local regen = math.floor(skill / 7) + 1
    local refresh = math.floor(skill / 100) + 1
    local haste = (math.floor(skill / 20) + 1) * 100

    target:addMod(tpz.mod.REGEN, regen)
    target:addMod(tpz.mod.REFRESH, refresh)
    target:addMod(tpz.mod.HASTE_MAGIC, haste)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local skill = effect:getPower()
    local regen = math.floor(skill / 7) + 1
    local refresh = math.floor(skill / 100) + 1
    local haste = (math.floor(skill / 20) + 1) * 100

    target:delMod(tpz.mod.REGEN, regen)
    target:delMod(tpz.mod.REFRESH, refresh)
    target:delMod(tpz.mod.HASTE_MAGIC, haste)
end

return effect_object
