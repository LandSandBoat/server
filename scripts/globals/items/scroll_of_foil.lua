-----------------------------------
-- ID: 5102
-- Scroll of Foil
-- Teaches the white magic Foil
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(840)
end

item_object.onItemUse = function(target)
    target:addSpell(840)
end

return item_object
