-----------------------------------
-- ID: 4783
-- Scroll of Firaga II
-- Teaches the black magic Firaga II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(175)
end

item_object.onItemUse = function(target)
    target:addSpell(175)
end

return item_object
