-----------------------------------------
-- ID: 4937
-- Scroll of Doton: Ichi
-- Teaches the ninjutsu Doton: Ichi
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(329)
end

item_object.onItemUse = function(target)
    target:addSpell(329)
end

return item_object
