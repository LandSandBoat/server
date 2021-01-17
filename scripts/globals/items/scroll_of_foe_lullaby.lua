-----------------------------------------
-- ID: 5071
-- Scroll of Foe Lullaby
-- Teaches the song Foe Lullaby
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(463)
end

item_object.onItemUse = function(target)
    target:addSpell(463)
end

return item_object
