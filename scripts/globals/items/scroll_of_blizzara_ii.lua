-----------------------------------
-- ID: 4919
-- Scroll of Blizzara II
-- Teaches the black magic Blizzara II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(831)
end

item_object.onItemUse = function(target)
    target:addSpell(831)
end

return item_object
