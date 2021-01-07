-----------------------------------
--
-- tpz.effect.BARSILENCE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SILENCERES, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SILENCERES, effect:getPower())
end

return effecttbl
