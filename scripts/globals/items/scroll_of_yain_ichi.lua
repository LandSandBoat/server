-----------------------------------------
-- ID: 4971
-- Scroll of Yain: Ichi
-- Teaches the ninjutsu Yain: Ichi
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(506)
end

item_object.onItemUse = function(target)
    target:addSpell(506)
end

return item_object
