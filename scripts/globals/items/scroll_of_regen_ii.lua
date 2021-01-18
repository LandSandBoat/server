-----------------------------------
-- ID: 4718
-- Scroll of Regen II
-- Teaches the white magic Regen II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(110)
end

item_object.onItemUse = function(target)
    target:addSpell(110)
end

return item_object
