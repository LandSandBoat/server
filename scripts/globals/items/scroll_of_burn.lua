-----------------------------------
-- ID: 4843
-- Scroll of Burn
-- Teaches the black magic Burn
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(235)
end

item_object.onItemUse = function(target)
    target:addSpell(235)
end

return item_object
