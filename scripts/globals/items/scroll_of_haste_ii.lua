-----------------------------------
-- ID: 4692
-- Scroll of Haste II
-- Teaches the white magic Haste II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(511)
end

item_object.onItemUse = function(target)
    target:addSpell(511)
end

return item_object
