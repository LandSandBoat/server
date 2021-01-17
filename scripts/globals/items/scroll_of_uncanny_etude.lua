-----------------------------------------
-- ID: 5040
-- Scroll of Uncanny Etude
-- Teaches the song Uncanny Etude
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(432)
end

item_object.onItemUse = function(target)
    target:addSpell(432)
end

return item_object
