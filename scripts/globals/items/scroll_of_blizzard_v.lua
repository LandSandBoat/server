-----------------------------------
-- ID: 4761
-- Scroll of Blizzard V
-- Teaches the black magic Blizzard V
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(153)
end

item_object.onItemUse = function(target)
    target:addSpell(153)
end

return item_object
