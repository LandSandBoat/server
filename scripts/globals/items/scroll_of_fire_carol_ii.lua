-----------------------------------------
-- ID: 5054
-- Scroll of Fire Carol II
-- Teaches the song Fire Carol II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(446)
end

item_object.onItemUse = function(target)
    target:addSpell(446)
end

return item_object
