----------------------------------------
-- tpz.effect.ELEMENTAL_SFORZO
----------------------------------------
require("scripts/globals/status")
----------------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.UDMGMAGIC, -100)
    -- Todo: status resists
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.UDMGMAGIC, -100)
    -- Todo: status resists
end

return effect_object
