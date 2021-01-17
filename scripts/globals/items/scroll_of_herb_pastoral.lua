-----------------------------------------
-- ID: 5014
-- Scroll of Herb Pastoral
-- Teaches the song Herb Pastoral
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(406)
end

item_object.onItemUse = function(target)
    target:addSpell(406)
end

return item_object
