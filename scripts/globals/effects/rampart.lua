-----------------------------------
--     tpz.effect.RAMPART
-----------------------------------

function onEffectGain(target, effect)
    local power = -1 * effect:getPower()
    target:addMod(tpz.mod.UDMGPHYS, power)
    target:addMod(tpz.mod.UDMGBREATH, power)
    target:addMod(tpz.mod.UDMGMAGIC, power)
    target:addMod(tpz.mod.UDMGRANGE, power)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = -1 * effect:getPower()
    target:delMod(tpz.mod.UDMGPHYS, power)
    target:delMod(tpz.mod.UDMGBREATH, power)
    target:delMod(tpz.mod.UDMGMAGIC, power)
    target:delMod(tpz.mod.UDMGRANGE, power)
end
