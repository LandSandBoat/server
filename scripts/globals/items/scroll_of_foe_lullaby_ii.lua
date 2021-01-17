-----------------------------------------
-- ID: 5079
-- Scroll of Foe Lullaby II
-- Teaches the song Foe Lullaby II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(471)
end

item_object.onItemUse = function(target)
    target:addSpell(471)
end

return item_object
