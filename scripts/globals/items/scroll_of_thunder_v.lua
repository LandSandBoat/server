
-----------------------------------------
-- ID: 4776
-- Scroll of thunder v
-- Teaches the black magic thunder v
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(168)
end

item_object.onItemUse = function(target)
    target:addSpell(168)
end

return item_object
