-----------------------------------
-- ID: 15507
-- Item: Purgatory Collar
-- Item Effect: Conserve MP
-- Duration: 45 seconds
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.PURGATORY_COLLAR) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.PURGATORY_COLLAR)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.PURGATORY_COLLAR) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 45, 0, 0, 0, xi.items.PURGATORY_COLLAR)
    end
end

itemObject.onEffectGain = function(target)
    -- **Power needs validation**
    target:addMod(xi.mod.CONSERVE_MP, 10)
end

itemObject.onEffectLose = function(target)
    target:delMod(xi.mod.CONSERVE_MP, 10)
end

return itemObject
