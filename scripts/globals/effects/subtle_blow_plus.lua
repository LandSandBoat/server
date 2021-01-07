-----------------------------------
-- tpz.effect.SUBTLE_BLOW_PLUS
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SUBTLE_BLOW, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SUBTLE_BLOW, effect:getPower())
end

return effect_object
