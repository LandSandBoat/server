-----------------------------------
-- ID: 15864
-- Item: tough_belt
-- Item Effect: VIT +3
-- Duration: 60 seconds
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15864 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 600, 15864)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 3)
end

return itemObject
