-----------------------------------
-- ID: 5105
-- Scroll of Flurry II
-- Teaches the white magic Flurry II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(846)
end

item_object.onItemUse = function(target)
    target:addSpell(846)
end

return item_object
