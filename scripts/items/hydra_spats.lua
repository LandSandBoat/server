-----------------------------------
-- ID: 15681
-- Item: hydra_spats
-- Item Effect: Eva +15
-- Duration: 20 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.EVASION_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_SPATS) ~= nil then
        target:delStatusEffect(xi.effect.EVASION_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_SPATS)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HYDRA_SPATS) then
        target:addStatusEffect(xi.effect.EVASION_BOOST, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_SPATS)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.EVA, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
