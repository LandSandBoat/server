-----------------------------------
-- ID: 15290
-- Item: Haste Belt
-- Item Effect: 10% haste
-----------------------------------

local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.HASTE_BELT) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.HASTE_BELT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.HASTE_BELT) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.HASTE_BELT)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HASTE_MAGIC, 1000)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HASTE_MAGIC, 1000)
end

return itemObject
