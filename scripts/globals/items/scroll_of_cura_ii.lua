-----------------------------------------
-- ID: 5082
-- Scroll of Cura II
-- Teaches the white magic Cura II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(474)
end

item_object.onItemUse = function(target)
    target:addSpell(474)
end

return item_object
