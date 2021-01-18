-----------------------------------
-- ID: 4988
-- Scroll of Armys Paeton III
-- Teaches the song Armys Paeton III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(380)
end

item_object.onItemUse = function(target)
    target:addSpell(380)
end

return item_object
