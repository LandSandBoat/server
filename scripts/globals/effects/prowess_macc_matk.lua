-----------------------------------
--
-- tpz.effect.PROWESS : Enhanced magic acc. and magic atk
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MATT, effect:getPower())
    target:addMod(tpz.mod.MACC, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MATT, effect:getPower())
    target:delMod(tpz.mod.MACC, effect:getPower())
end
