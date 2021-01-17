-----------------------------------------
-- ID: 5050
-- Scroll of Lightning Carol
-- Teaches the song Lightning Carol
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(442)
end

item_object.onItemUse = function(target)
    target:addSpell(442)
end

return item_object
