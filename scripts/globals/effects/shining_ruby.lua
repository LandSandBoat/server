-----------------------------------
-- tpz.effect.SHININY_RUBY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEFP, 10)
    target:addMod(tpz.mod.MDEF, 4)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEFP, 10)
    target:delMod(tpz.mod.MDEF, 4)
end

return effecttbl
