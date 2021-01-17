-----------------------------------------
-- ID: 5046
-- Scroll of Fire Carol
-- Teaches the song Fire Carol
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(438)
end

item_object.onItemUse = function(target)
    target:addSpell(438)
end

return item_object
