-----------------------------------------
-- ID: 4677
-- Scroll of Barstonra
-- Teaches the white magic Barstonra
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(69)
end

item_object.onItemUse = function(target)
    target:addSpell(69)
end

return item_object
