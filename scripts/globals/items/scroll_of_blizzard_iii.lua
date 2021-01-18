-----------------------------------
-- ID: 4759
-- Scroll of Blizzard III
-- Teaches the black magic Blizzard III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(151)
end

item_object.onItemUse = function(target)
    target:addSpell(151)
end

return item_object
