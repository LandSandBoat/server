-----------------------------------------
-- ID: 4976
-- Scroll of Foe Requiem
-- Teaches the song Foe Requiem
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(368)
end

item_object.onItemUse = function(target)
    target:addSpell(368)
end

return item_object
