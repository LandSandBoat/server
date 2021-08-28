-----------------------------------
-- xi.effect.ELEMENTAL_SFORZO
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UDMGMAGIC, -10000)
    -- Todo: status resists
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.UDMGMAGIC, -10000)
    -- Todo: status resists
end

return effect_object
