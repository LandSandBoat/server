-----------------------------------
-- tpz.effect.VOIDSTORM
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.DEX, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.VIT, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.AGI, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.INT, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.MND, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.CHR, math.floor(effect:getPower()/2))
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.DEX, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.VIT, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.AGI, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.INT, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.MND, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.CHR, math.floor(effect:getPower()/2))
end

return effect_object
