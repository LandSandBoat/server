-----------------------------------
-- tpz.effect.ENFIRE_II
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ENSPELL, tpz.magic.element.FIRE + 8) -- Tier IIs have higher "enspell IDs"
    target:addMod(tpz.mod.ENSPELL_DMG, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setMod(tpz.mod.ENSPELL_DMG, 0)
    target:setMod(tpz.mod.ENSPELL, 0)
end

return effect_object
