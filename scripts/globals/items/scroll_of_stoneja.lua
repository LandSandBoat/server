-----------------------------------
-- ID: 4893
-- Scroll of Stoneja
-- Teaches the black magic Stoneja
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(499)
end

item_object.onItemUse = function(target)
    target:addSpell(499)
end

return item_object
