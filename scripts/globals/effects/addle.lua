-----------------------------------
--
-- tpz.effect.ADDLE
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FASTCAST, -effect:getPower()) -- Yes we are subtracting in addMod()
    target:addMod(tpz.mod.MACC, -effect:getSubPower()) -- This is intentional
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FASTCAST, -effect:getPower())
    target:delMod(tpz.mod.MACC, -effect:getSubPower())
end
