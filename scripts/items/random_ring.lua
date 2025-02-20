-----------------------------------
-- ID: 15770
-- Item: Random Ring
-- Item Effect: Enchantment Dex + math.random(1, 8)
-- Duration: 30 Mins
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.RANDOM_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.RANDOM_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.RANDOM_RING) then
        local power = math.random(1, 8)

        target:addStatusEffect(xi.effect.ENCHANTMENT, power, 0, 3600, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.RANDOM_RING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, effect:getPower())
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, effect:getPower())
end

return itemObject
