-----------------------------------
-- ID: 6570
-- Scroll of Paralyze II
-- Teaches the white magic Paralyze II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(80)
end

item_object.onItemUse = function(target)
    target:addSpell(80)
end

return item_object
