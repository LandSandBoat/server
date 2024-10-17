-----------------------------------
-- ID: 14516
-- Item: hydra_harness
-- Item Effect: Attack +25, Ranged Attack +25
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_HARNESS) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_HARNESS)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HYDRA_HARNESS) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_HARNESS)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATT, 25)
    target:addMod(xi.mod.RATT, 25)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, 25)
    target:delMod(xi.mod.RATT, 25)
end

return itemObject
