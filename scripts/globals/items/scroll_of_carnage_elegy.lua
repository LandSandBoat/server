-----------------------------------------
-- ID: 5030
-- Scroll of Carnage Elegy
-- Teaches the song Carnage Elegy
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(422)
end

item_object.onItemUse = function(target)
    target:addSpell(422)
end

return item_object
