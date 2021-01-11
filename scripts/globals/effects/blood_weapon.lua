-----------------------------------
-- tpz.effect.BLOOD_WEAPON
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ENSPELL, 17)
    target:addMod(tpz.mod.ENSPELL_DMG, 1)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setMod(tpz.mod.ENSPELL_DMG, 0)
    target:setMod(tpz.mod.ENSPELL, 0)
end

return effect_object
