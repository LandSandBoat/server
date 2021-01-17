-----------------------------------------
-- ID: 4655
-- Scroll of Protect V
-- Teaches the white magic Protect V
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(47)
end

item_object.onItemUse = function(target)
    target:addSpell(47)
end

return item_object
