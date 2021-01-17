-----------------------------------------
-- ID: 4964
-- Scroll of Monomi: Ichi
-- Teaches the ninjutsu Monomi: Ichi
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(318)
end

item_object.onItemUse = function(target)
    target:addSpell(318)
end

return item_object
