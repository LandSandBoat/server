-----------------------------------------
-- ID: 5012
-- Scroll of Dragonfoe Mambo
-- Teaches the song Dragonfoe Mambo
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(404)
end

item_object.onItemUse = function(target)
    target:addSpell(404)
end

return item_object
