-----------------------------------------
-- ID: 4931
-- Scroll of Hyoton: Ni
-- Teaches the ninjutsu Hyoton: Ni
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(324)
end

item_object.onItemUse = function(target)
    target:addSpell(324)
end

return item_object
