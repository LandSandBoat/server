----------------------------------------
--
--     tpz.effect.MANA_WALL
--
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DMG, 50)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DMG, 50)
end

return effecttbl
