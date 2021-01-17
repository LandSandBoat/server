-----------------------------------------
-- ID: 5034
-- Scroll of Vivacious Etude
-- Teaches the song Vivacious Etude
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(426)
end

item_object.onItemUse = function(target)
    target:addSpell(426)
end

return item_object
