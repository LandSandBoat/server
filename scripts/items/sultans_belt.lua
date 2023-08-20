-----------------------------------
-- ID: 15867
-- Item: sultans_belt
-- Item Effect: STR +10
-- Duration: 60 seconds
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15867 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 15867)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 10)
end

return itemObject
