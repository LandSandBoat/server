-----------------------------------
-- tpz.effect.PHYSICAL_SHIELD
-- Blocks all physical attacks
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    if (effect:getPower() < 2) then
        target:addMod(tpz.mod.UDMGPHYS, -100)
    else
        target:addMod(tpz.mod.PHYS_ABSORB, 100)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if (effect:getPower() < 2) then
        target:delMod(tpz.mod.UDMGPHYS, -100)
    else
        target:delMod(tpz.mod.PHYS_ABSORB, 100)
    end
end

return effect_object
