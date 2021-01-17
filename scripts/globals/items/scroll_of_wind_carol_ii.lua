-----------------------------------------
-- ID: 5056
-- Scroll of Wind Carol II
-- Teaches the song Wind Carol II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(448)
end

item_object.onItemUse = function(target)
    target:addSpell(448)
end

return item_object
