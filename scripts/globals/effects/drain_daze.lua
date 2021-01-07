-----------------------------------
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ENSPELL_DMG, 0)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setMod(tpz.mod.ENSPELL_DMG, 0)
end

return effecttbl
