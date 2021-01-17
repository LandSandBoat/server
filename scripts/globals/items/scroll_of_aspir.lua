-----------------------------------------
-- ID: 4855
-- Scroll of Aspir
-- Teaches the black magic Aspir
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(247)
end

item_object.onItemUse = function(target)
    target:addSpell(247)
end

return item_object
