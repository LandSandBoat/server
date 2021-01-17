-----------------------------------------
-- ID: 4688
-- Scroll of Recall-Pashh
-- Teaches the white magic Recall-Pashh
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(82)
end

item_object.onItemUse = function(target)
    target:addSpell(82)
end

return item_object
