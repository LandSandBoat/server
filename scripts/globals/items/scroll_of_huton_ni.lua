-----------------------------------------
-- ID: 4935
-- Scroll of Huton: Ni
-- Teaches the ninjutsu Huton: Ni
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(327)
end

item_object.onItemUse = function(target)
    target:addSpell(327)
end

return item_object
