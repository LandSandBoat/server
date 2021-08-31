-----------------------------------
-- ID: 4987
-- Scroll of Armys Paeton II
-- Teaches the song Armys Paeton II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(379)
end

item_object.onItemUse = function(target)
    target:addSpell(379)
end

return item_object
