-----------------------------------------
-- ID: 4962
-- Scroll of Tonko: Ichi
-- Teaches the ninjutsu Tonko: Ichi
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(354)
end

item_object.onItemUse = function(target)
    target:addSpell(354)
end

return item_object
