-----------------------------------
-- ID: 5013
-- Scroll of Fowl Aubade
-- Teaches the song Fowl Aubade
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(405)
end

item_object.onItemUse = function(target)
    target:addSpell(405)
end

return item_object
