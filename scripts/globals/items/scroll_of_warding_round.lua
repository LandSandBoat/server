-----------------------------------------
-- ID: 5022
-- Scroll of Warding Round
-- Teaches the song Warding Round
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(414)
end

item_object.onItemUse = function(target)
    target:addSpell(414)
end

return item_object
