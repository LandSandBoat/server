----------------------------------------
--
--   tpz.effect.TERNARY_FLOURISH
--
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.TRIPLE_ATTACK, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.TRIPLE_ATTACK, 100)
end

return effecttbl
