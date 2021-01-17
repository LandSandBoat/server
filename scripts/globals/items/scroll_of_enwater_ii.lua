-----------------------------------------
-- ID: 4727
-- Scroll of Enwater II
-- Teaches the white magic Enwater II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(317)
end

item_object.onItemUse = function(target)
    target:addSpell(317)
end

return item_object
