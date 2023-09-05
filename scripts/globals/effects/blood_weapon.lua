-----------------------------------
-- xi.effect.BLOOD_WEAPON
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ENSPELL, 17)
    target:addMod(xi.mod.ENSPELL_DMG, 1)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setMod(xi.mod.ENSPELL_DMG, 0)
    target:setMod(xi.mod.ENSPELL, 0)
end

return effectObject
