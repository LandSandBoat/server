-----------------------------------
-- ID: 4696
-- Scroll of Barparalyzra
-- Teaches the white magic Barparalyzra
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(88)
end

item_object.onItemUse = function(target)
    target:addSpell(88)
end

return item_object
