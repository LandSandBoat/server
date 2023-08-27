-----------------------------------
-- ID: 14864
-- Item: Palmer's Bangles
-- Item Effect: Gilfinder
-- Duration: 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.PALMERS_BANGLES) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.PALMERS_BANGLES)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.PALMERS_BANGLES) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.PALMERS_BANGLES)
    end
end

itemObject.onEffectGain = function(target)
    target:addMod(xi.mod.GILFINDER, 3)
end

itemObject.onEffectLose = function(target)
    target:delMod(xi.mod.GILFINDER, 3)
end

return itemObject
