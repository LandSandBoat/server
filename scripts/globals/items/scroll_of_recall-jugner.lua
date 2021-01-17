-----------------------------------------
-- ID: 4687
-- Scroll of Recall-Jugner
-- Teaches the white magic Recall-Jugner
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(81)
end

item_object.onItemUse = function(target)
    target:addSpell(81)
end

return item_object
