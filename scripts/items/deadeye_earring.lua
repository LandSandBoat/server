-----------------------------------
-- ID: 14787
-- Item: Deadeye Earring
-- Item Effect: Ranged Attack 20
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEADEYE_EARRING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEADEYE_EARRING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.DEADEYE_EARRING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEADEYE_EARRING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.RATT, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.RATT, 20)
end

return itemObject
