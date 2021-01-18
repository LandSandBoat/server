-----------------------------------
-- ID: 4681
-- Scroll of Barpoison
-- Teaches the white magic Barpoison
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(73)
end

item_object.onItemUse = function(target)
    target:addSpell(73)
end

return item_object
