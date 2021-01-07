-----------------------------------
-- tpz.effect.BEAST_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addPetMod(tpz.mod.ATTP, effect:getPower())
    target:addPetMod(tpz.mod.RATTP, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delPetMod(tpz.mod.ATTP, effect:getPower())
    target:delPetMod(tpz.mod.RATTP, effect:getPower())
end

return effect_object
