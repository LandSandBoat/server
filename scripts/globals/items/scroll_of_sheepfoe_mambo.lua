-----------------------------------
-- ID: 5011
-- Scroll of Sheepfoe Mambo
-- Teaches the song Sheepfoe Mambo
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(403)
end

item_object.onItemUse = function(target)
    target:addSpell(403)
end

return item_object
