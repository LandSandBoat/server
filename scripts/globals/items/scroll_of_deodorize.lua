-----------------------------------
-- ID: 4746
-- Scroll of Deodorize
-- Teaches the white magic Deodorize
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(138)
end

item_object.onItemUse = function(target)
    target:addSpell(138)
end

return item_object
