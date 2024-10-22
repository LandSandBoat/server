-----------------------------------
-- ID: 14517
-- Item: Hydra Haubert
-- Item Effect: gives refresh
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HYDRA_HAUBERT) then
        if target:hasStatusEffect(xi.effect.REFRESH) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.REFRESH, 3, 3, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_HAUBERT)
        end
    end
end

return itemObject
