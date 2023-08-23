-----------------------------------
-- ID: 4172
-- Item: Reraiser
-- Item Effect: +50% HP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local duration = 900
    target:delStatusEffect(xi.effect.MAX_HP_BOOST)
    target:addStatusEffect(xi.effect.MAX_HP_BOOST, 50, 0, duration)
end

return itemObject
