-----------------------------------
-- xi.effect.PHYSICAL_SHIELD
-- Blocks all physical attacks
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if (effect:getPower() < 2) then
        target:addMod(xi.mod.UDMGPHYS, -10000)
    else
        target:addMod(xi.mod.PHYS_ABSORB, 10000)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    if (effect:getPower() < 2) then
        target:delMod(xi.mod.UDMGPHYS, -10000)
    else
        target:delMod(xi.mod.PHYS_ABSORB, 10000)
    end
end

return effect_object
