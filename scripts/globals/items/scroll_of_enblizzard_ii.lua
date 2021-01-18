-----------------------------------
-- ID: 4723
-- Scroll of Enblizzard II
-- Teaches the white magic Enblizzard II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(313)
end

item_object.onItemUse = function(target)
    target:addSpell(313)
end

return item_object
