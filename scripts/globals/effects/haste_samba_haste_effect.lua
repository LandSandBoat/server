-----------------------------------
-- tpz.effect.HASTE_SAMBA_HASTE_EFFECT
-- JA Haste 5-10%
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HASTE_ABILITY, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HASTE_ABILITY, effect:getPower())
end

return effect_object
