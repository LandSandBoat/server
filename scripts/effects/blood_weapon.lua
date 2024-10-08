-----------------------------------
-- xi.effect.BLOOD_WEAPON
-- Does not overwritte any existing "Enspell" effect, including "Soul Enslavement"
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ENSPELL, 17)
    effect:addMod(xi.mod.ENSPELL_DMG, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
