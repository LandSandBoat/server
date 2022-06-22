-----------------------------------
-- ID: 4916
-- Scroll of Fira
-- Teaches the black magic Fira
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(828)
end

item_object.onItemUse = function(target)
    target:addSpell(828)
end

return item_object
