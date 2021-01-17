-----------------------------------------
-- ID: 4940
-- Scroll of Raiton: Ichi
-- Teaches the ninjutsu Raiton: Ichi
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(332)
end

item_object.onItemUse = function(target)
    target:addSpell(332)
end

return item_object
