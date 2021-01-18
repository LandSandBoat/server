-----------------------------------
-- ID: 4788
-- Scroll of Blizzaga II
-- Teaches the black magic Blizzaga II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(180)
end

item_object.onItemUse = function(target)
    target:addSpell(180)
end

return item_object
