-----------------------------------------
-- ID: 4624
-- Scroll of Blindna
-- Teaches the white magic Blindna
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(16)
end

item_object.onItemUse = function(target)
    target:addSpell(16)
end

return item_object
