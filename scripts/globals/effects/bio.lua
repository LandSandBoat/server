-----------------------------------
--
-- tpz.effect.BIO
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:addMod(tpz.mod.ATTP, -subpower)
    target:addMod(tpz.mod.REGEN_DOWN, power)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:delMod(tpz.mod.ATTP, -subpower)
    target:delMod(tpz.mod.REGEN_DOWN, power)
end
