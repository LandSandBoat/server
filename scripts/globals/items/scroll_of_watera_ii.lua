-----------------------------------
-- ID: 4927
-- Scroll of Watera II
-- Teaches the black magic Watera II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(839)
end

item_object.onItemUse = function(target)
    target:addSpell(839)
end

return item_object
