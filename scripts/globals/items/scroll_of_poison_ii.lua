-----------------------------------
-- ID: 4829
-- Scroll of Poison II
-- Teaches the black magic Poison II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(221)
end

item_object.onItemUse = function(target)
    target:addSpell(221)
end

return item_object
