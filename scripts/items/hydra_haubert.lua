-----------------------------------
-- ID: 14517
-- Item: Hydra Haubert
-- Item Effect: 3 mp/tick refresh for 60s
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.REFRESH, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_HAUBERT) ~= nil then
        target:delStatusEffect(xi.effect.REFRESH, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_HAUBERT)
    end

    return 0
end

itemObject.onItemUse = function(target)    if target:hasEquipped(xi.item.HYDRA_HAUBERT) then
        target:addStatusEffect(xi.effect.REFRESH, 0, 0, 60, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_HAUBERT)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.REFRESH, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
