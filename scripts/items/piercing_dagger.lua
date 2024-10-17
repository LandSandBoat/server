-----------------------------------
-- ID: 18029
-- Item: piercing_dagger
-- Item Effect: Attack +3
-- Duration: 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ATTACK_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PIERCING_DAGGER) ~= nil then
        target:delStatusEffect(xi.effect.ATTACK_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PIERCING_DAGGER)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.PIERCING_DAGGER) then
        target:addStatusEffect(xi.effect.ATTACK_BOOST, 3, 0, 1800, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PIERCING_DAGGER)
    end
end

return itemObject
