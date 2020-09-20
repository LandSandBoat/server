-----------------------------------
--
-- tpz.effect.PROWESS : Treasure Hunter bonus
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.TREASURE_HUNTER, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.TREASURE_HUNTER, effect:getPower())
end
