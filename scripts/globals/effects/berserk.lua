-----------------------------------
--
-- tpz.effect.BERSERK
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    local power = effect:getPower()
    target:addMod(tpz.mod.ATTP, power)
    target:addMod(tpz.mod.RATTP, power)
    target:addMod(tpz.mod.DEFP, -power)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    target:delMod(tpz.mod.ATTP, power)
    target:delMod(tpz.mod.RATTP, power)
    target:delMod(tpz.mod.DEFP, -power)
end

return effecttbl
