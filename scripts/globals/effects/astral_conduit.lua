----------------------------------------
-- tpz.effect.ASTRAL_CONDUIT
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.BP_DELAY, 99)
    target:addMod(tpz.mod.MPP, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.BP_DELAY, 99)
    target:delMod(tpz.mod.MPP, 100)
end

return effect_object
