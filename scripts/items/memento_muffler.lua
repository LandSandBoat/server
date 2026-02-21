-----------------------------------
-- ID: 13173
-- Item: Memento Muffler
-- Item Effect: VIT +7
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, user)
    if target:getStatusEffectBySource(xi.effect.VIT_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MEMENTO_MUFFLER) ~= nil then
        target:delStatusEffect(xi.effect.VIT_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MEMENTO_MUFFLER)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.MEMENTO_MUFFLER) then
        target:addStatusEffect(xi.effect.VIT_BOOST, { duration = 300, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.MEMENTO_MUFFLER })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.VIT, 7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
