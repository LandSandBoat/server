-----------------------------------------
-- ID: 4956
-- Scroll of Kurayami: Ni
-- Teaches the ninjutsu Kurayami: Ni
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(348)
end

item_object.onItemUse = function(target)
    target:addSpell(348)
end

return item_object
