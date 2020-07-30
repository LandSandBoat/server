-----------------------------------
--
-- tpz.effect.PROWESS : Enhanced accuracy and ranged accuracy
--
-----------------------------------

function onEffectGain(target, effect)
-- This might not be % in retail...If not a % just change ACCP to just ACC
    target:addMod(tpz.mod.ACC, effect:getPower())
    target:addMod(tpz.mod.RACC, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ACC, effect:getPower())
    target:delMod(tpz.mod.RACC, effect:getPower())
end
