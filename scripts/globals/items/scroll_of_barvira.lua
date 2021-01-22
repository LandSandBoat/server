-----------------------------------
-- ID: 4700
-- Scroll of Barvira
-- Teaches the white magic Barvira
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(92)
end

item_object.onItemUse = function(target)
    target:addSpell(92)
end

return item_object
