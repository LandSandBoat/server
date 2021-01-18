-----------------------------------
-- ID: 4808
-- Scroll of Waterga II
-- Teaches the black magic Waterga II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(200)
end

item_object.onItemUse = function(target)
    target:addSpell(200)
end

return item_object
