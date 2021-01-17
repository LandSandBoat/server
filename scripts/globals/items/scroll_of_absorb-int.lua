-----------------------------------------
-- ID: 4878
-- Scroll of Absorb-INT
-- Teaches the black magic Absorb-INT
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(270)
end

item_object.onItemUse = function(target)
    target:addSpell(270)
end

return item_object
