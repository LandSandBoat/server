-----------------------------------
-- tpz.effect.STONESKIN
-- Absorbs a certain amount of damage from physical and magical attacks.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:setMod(tpz.mod.STONESKIN, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setMod(tpz.mod.STONESKIN, 0)
end

return effect_object
