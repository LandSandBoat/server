-----------------------------------------
-- ID: 15485
-- Item: Talisman Cape
-- Effect: 30Min, MP+12 Enmity-2
-----------------------------------------
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.TALISMAN_CAPE) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.TALISMAN_CAPE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.TALISMAN_CAPE) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.TALISMAN_CAPE)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 12)
    target:addMod(xi.mod.ENMITY, -2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 12)
    target:delMod(xi.mod.ENMITY, -2)
end

return itemObject
