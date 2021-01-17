-----------------------------------------
-- ID: 5029
-- Scroll of Battlefield Elegy
-- Teaches the song Battlefield Elegy
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(421)
end

item_object.onItemUse = function(target)
    target:addSpell(421)
end

return item_object
