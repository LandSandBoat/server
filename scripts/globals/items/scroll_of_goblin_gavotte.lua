-----------------------------------------
-- ID: 5023
-- Scroll of Goblin Gavotte
-- Teaches the song Goblin Gavotte
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(415)
end

item_object.onItemUse = function(target)
    target:addSpell(415)
end

return item_object
