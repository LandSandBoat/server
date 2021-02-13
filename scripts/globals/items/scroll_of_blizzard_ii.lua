-----------------------------------
-- ID: 4758
-- Scroll of Blizzard II
-- Teaches the black magic Blizzard II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(150)
end

item_object.onItemUse = function(target)
    target:addSpell(150)
end

return item_object
