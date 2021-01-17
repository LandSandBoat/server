-----------------------------------------
-- ID: 4717
-- Scroll of Refresh
-- Teaches the white magic Refresh
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(109)
end

item_object.onItemUse = function(target)
    target:addSpell(109)
end

return item_object
