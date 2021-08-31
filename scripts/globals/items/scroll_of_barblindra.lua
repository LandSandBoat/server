-----------------------------------
-- ID: 4697
-- Scroll of Barblindra
-- Teaches the white magic Barblindra
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(89)
end

item_object.onItemUse = function(target)
    target:addSpell(89)
end

return item_object
