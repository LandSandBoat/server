-----------------------------------------
-- ID: 5096
-- Scroll of Boost-VIT
-- Teaches the white magic Boost-VIT
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(481)
end

item_object.onItemUse = function(target)
    target:addSpell(481)
end

return item_object
