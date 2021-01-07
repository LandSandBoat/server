-----------------------------------
-- tpz.effect.ALCHEMY_IMAGERY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ALCHEMY, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ALCHEMY, effect:getPower())
end

return effecttbl
