-----------------------------------------
-- ID: 5095
-- Scroll of Boost-DEX
-- Teaches the white magic Boost-DEX
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(480)
end

item_object.onItemUse = function(target)
    target:addSpell(480)
end

return item_object
