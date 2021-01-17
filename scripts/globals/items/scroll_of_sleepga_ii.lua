-----------------------------------------
-- ID: 4882
-- Scroll of Sleepga II
-- Teaches the black magic Sleepga II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(274)
end

item_object.onItemUse = function(target)
    target:delSpell(364)
    target:addSpell(274)
end

return item_object
