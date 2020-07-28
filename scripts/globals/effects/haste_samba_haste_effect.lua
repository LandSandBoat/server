-----------------------------------
-- Haste Samba Haste Effect
-- JA Haste 5-10%
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HASTE_ABILITY, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HASTE_ABILITY, effect:getPower())
end
