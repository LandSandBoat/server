-----------------------------------
-- ID: 15868
-- Item: czars_belt
-- Item Effect: VIT +10
-- Duration: 60 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.CZARS_BELT) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.CZARS_BELT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.CZARS_BELT) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.CZARS_BELT)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 10)
end

return itemObject
