-----------------------------------------
-- ID: 4932
-- Scroll of Hyoton: San
-- Teaches the ninjutsu Hyoton: San
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(325)
end

item_object.onItemUse = function(target)
    target:addSpell(325)
end

return item_object
