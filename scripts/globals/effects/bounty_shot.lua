-----------------------------------
--
--     tpz.effect.BOUNTY_SHOT
--     
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.TREASURE_HUNTER, 40)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
end