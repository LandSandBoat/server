-----------------------------------------
-- ID: 4816
-- Scroll of Tornado
-- Teaches the black magic Tornado
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(208)
end

item_object.onItemUse = function(target)
    target:addSpell(208)
end

return item_object
