-----------------------------------
-- ID: 5104
-- Scroll of Flurry
-- Teaches the white magic Flurry
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(845)
end

item_object.onItemUse = function(target)
    target:addSpell(845)
end

return item_object
