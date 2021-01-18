-----------------------------------
-- ID: 4822
-- Scroll of Flood
-- Teaches the black magic Flood
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(214)
end

item_object.onItemUse = function(target)
    target:addSpell(214)
end

return item_object
