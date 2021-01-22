-----------------------------------
-- tpz.effect.THUNDER_MANEUVER
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local pet = target:getPet()
    if (pet) then
        pet:addMod(tpz.mod.DEX, effect:getPower())
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if (pet) then
        pet:delMod(tpz.mod.DEX, effect:getPower())
    end
end

return effect_object
