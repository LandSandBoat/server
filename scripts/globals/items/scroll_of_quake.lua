-----------------------------------------
-- ID: 4818
-- Scroll of Quake
-- Teaches the black magic Quake
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(210)
end

item_object.onItemUse = function(target)
    target:addSpell(210)
end

return item_object
