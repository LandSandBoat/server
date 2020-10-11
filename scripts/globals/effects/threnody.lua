-----------------------------------
-- Threnody
-- Reduces a targets given elemental resistance
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(effect:getSubPower(), effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(effect:getSubPower(), effect:getPower())
end
