-----------------------------------------
-- ID: 5057
-- Scroll of Earth Carol II
-- Teaches the song Earth Carol II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(449)
end

item_object.onItemUse = function(target)
    target:addSpell(449)
end

return item_object
