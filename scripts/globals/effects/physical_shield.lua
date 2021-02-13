-----------------------------------
-- tpz.effect.PHYSICAL_SHIELD
-- Blocks all physical attacks
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if (effect:getPower() < 2) then
        target:addMod(tpz.mod.UDMGPHYS, -100)
    else
        target:addMod(tpz.mod.PHYS_ABSORB, 100)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    if (effect:getPower() < 2) then
        target:delMod(tpz.mod.UDMGPHYS, -100)
    else
        target:delMod(tpz.mod.PHYS_ABSORB, 100)
    end
end

return effect_object
