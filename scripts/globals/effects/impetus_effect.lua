----------------------------------------
--
--     tpz.effect.IMPETUS_EFFECT
--
----------------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ATT, 100)
    target:addMod(tpz.mod.CRITHITRATE, 50)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATT, 100)
    target:delMod(tpz.mod.CRITHITRATE, 50)
end

return effecttbl
