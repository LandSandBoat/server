-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

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

return effecttbl
