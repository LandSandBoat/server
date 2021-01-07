-----------------------------------
-- tpz.effect.FOOTWORK
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.KICK_ATTACK_RATE, 20)
    target:addMod(tpz.mod.KICK_DMG, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.KICK_ATTACK_RATE, 20)
    target:delMod(tpz.mod.KICK_DMG, effect:getPower())
end

return effect_object
