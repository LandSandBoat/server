-----------------------------------
-- ID: 15320
-- Powder Boots
--  Enchantment: "Flee"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:delStatusEffect(xi.effect.FLEE)
    target:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
end

return itemObject
