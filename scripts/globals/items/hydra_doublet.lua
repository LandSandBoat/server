-----------------------------------
-- ID: 14515
-- Item: Hydra Doublet
-- Item Effect: gives refresh
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.REFRESH)
    if effect ~= nil and effect:getItemSourceID() == xi.items.HYDRA_DOUBLET then
        target:delStatusEffect(xi.effect.REFRESH)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.HYDRA_DOUBLET) then
        if target:hasStatusEffect(xi.effect.REFRESH) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.REFRESH, 3, 3, 180, 0, 0, 0, xi.items.HYDRA_DOUBLET)
        end
    end
end

return itemObject
