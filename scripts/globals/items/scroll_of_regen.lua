-----------------------------------
-- ID: 4716
-- Scroll of Regen
-- Teaches the white magic Regen
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(108)
end

item_object.onItemUse = function(target)
    target:addSpell(108)
end

return item_object
