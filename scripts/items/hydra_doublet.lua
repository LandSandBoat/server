-----------------------------------
-- ID: 14515
-- Item: Hydra Doublet
-- Item Effect: gives refresh
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.REFRESH) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.REFRESH, 4, 3, 180)
    end
end

return itemObject
