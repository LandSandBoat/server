-----------------------------------------
-- ID: 4712
-- Scroll of Enthunder
-- Teaches the white magic Enthunder
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(104)
end

item_object.onItemUse = function(target)
    target:addSpell(104)
end

return item_object
