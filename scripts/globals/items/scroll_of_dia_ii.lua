-----------------------------------------
-- ID: 4632
-- Scroll of Dia II
-- Teaches the white magic Dia II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(24)
end

item_object.onItemUse = function(target)
    target:addSpell(24)
end

return item_object
