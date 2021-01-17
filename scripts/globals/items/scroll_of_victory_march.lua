-----------------------------------------
-- ID: 5028
-- Scroll of Victory March
-- Teaches the song Victory March
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(420)
end

item_object.onItemUse = function(target)
    target:addSpell(420)
end

return item_object
