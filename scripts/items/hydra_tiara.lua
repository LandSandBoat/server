-----------------------------------
-- ID: 15261
-- Item: hydra_tiara
-- Item Effect: Crit Rate +7% **Needs validation**
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffectBySource(xi.effect.POTENCY, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_TIARA) ~= nil then
        target:delStatusEffect(xi.effect.POTENCY, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_TIARA)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HYDRA_TIARA) then
        target:addStatusEffect(xi.effect.POTENCY, 7, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_TIARA)
    end
end

return itemObject
