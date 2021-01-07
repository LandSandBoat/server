-----------------------------------
-- tpz.effect.THRENODY
-- Reduces a targets given elemental resistance
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(effect:getSubPower(), effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(effect:getSubPower(), effect:getPower())
end

return effecttbl
