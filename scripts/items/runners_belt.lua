-----------------------------------
-- ID: 15865
-- Item: runners_belt
-- Item Effect: DEX +3
-- Duration: 60 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.DEX_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.RUNNERS_BELT) ~= nil then
        target:delStatusEffect(xi.effect.DEX_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.RUNNERS_BELT)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.RUNNERS_BELT) then
        target:addStatusEffect(xi.effect.DEX_BOOST, { power = 3, duration = 60, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.RUNNERS_BELT })
    end
end

return itemObject
