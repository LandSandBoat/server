-----------------------------------
-- ID: 4990
-- Scroll of Armys Paeton V
-- Teaches the song Armys Paeton V
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(382)
end

item_object.onItemUse = function(target)
    target:addSpell(382)
end

return item_object
