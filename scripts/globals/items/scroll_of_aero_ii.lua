-----------------------------------------
-- ID: 4763
-- Scroll of Aero II
-- Teaches the black magic Aero II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(155)
end

item_object.onItemUse = function(target)
    target:addSpell(155)
end

return item_object
