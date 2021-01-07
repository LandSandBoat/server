-----------------------------------
-- tpz.effect..COUNTERSTANCE
-- DEF is removed in core as equip swaps can mess this up otherwise!
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.COUNTER, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.COUNTER, effect:getPower())
end

return effect_object
