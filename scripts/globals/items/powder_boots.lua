-----------------------------------
-- ID: 15320
-- Powder Boots
--  Enchantment: "Flee"
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:delStatusEffect(xi.effect.FLEE)
    target:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
end

return item_object
