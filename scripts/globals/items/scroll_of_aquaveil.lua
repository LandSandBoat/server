-----------------------------------
-- ID: 4663
-- Scroll of Aquaveil
-- Teaches the white magic Aquaveil
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(55)
end

item_object.onItemUse = function(target)
    target:addSpell(55)
end

return item_object
