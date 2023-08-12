-----------------------------------
-- ID: 15912
-- Item: Lieutenant's Sash
-- On Use: Removes food effect.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:delStatusEffect(xi.effect.FOOD)
end

return itemObject
