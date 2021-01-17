-----------------------------------------
-- ID: 4970
-- Scroll of Gekka: Ichi
-- Teaches the ninjutsu Gekka: Ichi
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(505)
end

item_object.onItemUse = function(target)
    target:addSpell(505)
end

return item_object
