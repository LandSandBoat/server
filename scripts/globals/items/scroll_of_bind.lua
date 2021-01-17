-----------------------------------------
-- ID: 4866
-- Scroll of Bind
-- Teaches the black magic Bind
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(258)
end

item_object.onItemUse = function(target)
    target:addSpell(258)
end

return item_object
