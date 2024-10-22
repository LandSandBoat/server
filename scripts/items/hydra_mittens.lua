-----------------------------------
-- ID: 14925
-- Item: hydra_mittens
-- Item Effect: ACC +15 RACC +15
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_MITTENS) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_MITTENS)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HYDRA_MITTENS) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_MITTENS)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 15)
    target:addMod(xi.mod.RACC, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 15)
    target:delMod(xi.mod.RACC, 15)
end

return itemObject
