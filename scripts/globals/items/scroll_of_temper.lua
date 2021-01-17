-----------------------------------------
-- ID: 4705
-- Scroll of Temper
-- Teaches the white magic Temper
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(493)
end

item_object.onItemUse = function(target)
    target:addSpell(493)
end

return item_object
