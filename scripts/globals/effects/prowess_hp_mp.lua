-----------------------------------
--
-- tpz.effect.PROWESS : Increased HP and MP
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HPP, effect:getPower())
    target:addMod(tpz.mod.MPP, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HPP, effect:getPower())
    target:delMod(tpz.mod.MPP, effect:getPower())
end
