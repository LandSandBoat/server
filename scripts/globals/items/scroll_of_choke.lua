-----------------------------------------
-- ID: 4845
-- Scroll of Choke
-- Teaches the black magic Choke
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(237)
end

item_object.onItemUse = function(target)
    target:addSpell(237)
end

return item_object
