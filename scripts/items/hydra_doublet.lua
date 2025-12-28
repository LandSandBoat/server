-----------------------------------
-- ID: 14515
-- Item: Hydra Doublet
-- Item Effect: 3 mp/tick refresh for 60s
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.REFRESH, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_DOUBLET) ~= nil then
        target:delStatusEffect(xi.effect.REFRESH, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_DOUBLET)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HYDRA_DOUBLET) then
        target:addStatusEffect(xi.effect.REFRESH, 0, 0, 60, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_DOUBLET)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.REFRESH, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
