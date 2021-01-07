-----------------------------------
-- tpz.effect.ICE_MANEUVER
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    local pet = target:getPet()
    if (pet) then
        pet:addMod(tpz.mod.INT, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local pet = target:getPet()
    if (pet) then
        pet:delMod(tpz.mod.INT, effect:getPower())
    end
end

return effect_object
