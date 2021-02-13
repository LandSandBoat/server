-----------------------------------
-- tpz.effect.RAMPART
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local power = -1 * effect:getPower()
    target:addMod(tpz.mod.UDMGPHYS, power)
    target:addMod(tpz.mod.UDMGBREATH, power)
    target:addMod(tpz.mod.UDMGMAGIC, power)
    target:addMod(tpz.mod.UDMGRANGE, power)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local power = -1 * effect:getPower()
    target:delMod(tpz.mod.UDMGPHYS, power)
    target:delMod(tpz.mod.UDMGBREATH, power)
    target:delMod(tpz.mod.UDMGMAGIC, power)
    target:delMod(tpz.mod.UDMGRANGE, power)
end

return effect_object
