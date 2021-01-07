----------------------------------------
--
--      tpz.effect.BLOOD_RAGE
--
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.CRITHITRATE, 20)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.CRITHITRATE, 20)
end

return effecttbl
