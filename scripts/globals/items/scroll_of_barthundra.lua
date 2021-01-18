-----------------------------------
-- ID: 4678
-- Scroll of Barthundra
-- Teaches the white magic Barthundra
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(70)
end

item_object.onItemUse = function(target)
    target:addSpell(70)
end

return item_object
