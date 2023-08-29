-----------------------------------
-- Item: Death Chakram
-- Item Effect: +5% MP
-- Duration 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.DEATH_CHAKRAM) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.DEATH_CHAKRAM)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.DEATH_CHAKRAM) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.DEATH_CHAKRAM)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPP, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPP, 5)
end

return itemObject
