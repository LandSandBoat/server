-----------------------------------
-- ID: 4666
-- Scroll of Paralyze
-- Teaches the white magic Paralyze
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(58)
end

item_object.onItemUse = function(target)
    target:addSpell(58)
end

return item_object
