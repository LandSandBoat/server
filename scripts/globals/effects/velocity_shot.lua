----------------------------------------
--
--    tpz.effect.VELOCITY_SHOT
--
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ATTP, -15)
    target:addMod(tpz.mod.HASTE_ABILITY, -1500)
    target:addMod(tpz.mod.RATTP, 15)
    target:addMod(tpz.mod.RANGED_DELAYP, -10)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATTP, -15)
    target:delMod(tpz.mod.HASTE_ABILITY, -1500)
    target:delMod(tpz.mod.RATTP, 15)
    target:delMod(tpz.mod.RANGED_DELAYP, -10)
end

return effecttbl
