-----------------------------------------
-- ID: 4984
-- Scroll of Horde Lullaby
-- Teaches the song Horde Lullaby
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(376)
end

item_object.onItemUse = function(target)
    target:addSpell(376)
end

return item_object
