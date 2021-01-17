-----------------------------------------
-- ID: 4719
-- Scroll of Regen III
-- Teaches the white magic Regen III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(111)
end

item_object.onItemUse = function(target)
    target:addSpell(111)
end

return item_object
