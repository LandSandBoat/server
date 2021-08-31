-----------------------------------
-- ID: 4991
-- Scroll of Armys Paeton VI
-- Teaches the song Armys Paeton VI
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(383)
end

item_object.onItemUse = function(target)
    target:addSpell(383)
end

return item_object
