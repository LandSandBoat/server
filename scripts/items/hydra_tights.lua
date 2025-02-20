-----------------------------------
-- ID: 15596
-- Item: Hydra Tights
-- Item Effect: 10% haste
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffectBySource(xi.effect.HASTE, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_TIGHTS) ~= nil then
        target:delStatusEffect(xi.effect.HASTE, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_TIGHTS)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HYDRA_TIGHTS) then
        if not target:hasStatusEffect(xi.effect.HASTE) then
            target:addStatusEffect(xi.effect.HASTE, 1000, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_TIGHTS)
        else
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        end
    end
end

return itemObject
