-----------------------------------
--
-- INHIBIT_TP
-- Reduces TP Gain By a % Factor
--
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INHIBIT_TP, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INHIBIT_TP, effect:getPower())
end

return effecttbl
