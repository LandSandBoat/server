-----------------------------------
--
-- tpz.effect.ATMA
--
-----------------------------------
require("scripts/globals/atma")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    tpz.atma.onEffectGain(target, effect)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    tpz.atma.onEffectLose(target, effect)
end

return effecttbl
