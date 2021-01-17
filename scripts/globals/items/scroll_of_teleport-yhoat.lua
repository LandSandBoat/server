-----------------------------------------
-- ID: 4728
-- Scroll of Teleport-Yhoat
-- Teaches the white magic Teleport-Yhoat
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(120)
end

item_object.onItemUse = function(target)
    target:addSpell(120)
end

return item_object
