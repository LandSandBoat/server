-----------------------------------
-- ID: 4923
-- Scroll of Stonera II
-- Teaches the black magic Stonera II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(835)
end

item_object.onItemUse = function(target)
    target:addSpell(835)
end

return item_object
