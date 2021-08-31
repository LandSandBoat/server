-----------------------------------
-- ID: 4989
-- Scroll of Armys Paeton IV
-- Teaches the song Armys Paeton IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(381)
end

item_object.onItemUse = function(target)
    target:addSpell(381)
end

return item_object
