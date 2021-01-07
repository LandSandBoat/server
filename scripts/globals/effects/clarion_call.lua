----------------------------------------
-- tpz.effect.CLARION_CALL
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MAXIMUM_SONGS_BONUS, 1)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MAXIMUM_SONGS_BONUS, 1)
end

return effect_object
