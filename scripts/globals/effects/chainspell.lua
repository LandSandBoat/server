-----------------------------------
-- tpz.effect.CHAINSPELL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.UFASTCAST, 150)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.UFASTCAST, 150)
end

return effecttbl
