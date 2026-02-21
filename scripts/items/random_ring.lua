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

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.RANDOM_RING) then
        local power = math.random(1, 8)

        target:addStatusEffect(xi.effect.ENCHANTMENT, { power = power, duration = 3600, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.RANDOM_RING })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, effect:getPower())
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
