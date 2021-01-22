-----------------------------------
-- ID: 4789
-- Scroll of Blizzaga III
-- Teaches the black magic Blizzaga III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(181)
end

item_object.onItemUse = function(target)
    target:addSpell(181)
end

return item_object
