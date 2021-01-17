-----------------------------------------
-- ID: 4961
-- Scroll of Tonko: Ichi
-- Teaches the ninjutsu Tonko: Ichi
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(353)
end

item_object.onItemUse = function(target)
    target:addSpell(353)
end

return item_object
