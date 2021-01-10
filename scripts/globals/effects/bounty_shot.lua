----------------------------------------
-- tpz.effect.BOUNTY_SHOT
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.TREASURE_HUNTER, 40)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.TREASURE_HUNTER, 40)
end

return effect_object
