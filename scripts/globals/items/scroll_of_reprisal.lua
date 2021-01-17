-----------------------------------------
-- ID: 4715
-- Scroll of Reprisal
-- Teaches the white magic Reprisal
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(97)
end

item_object.onItemUse = function(target)
    target:addSpell(97)
end

return item_object
