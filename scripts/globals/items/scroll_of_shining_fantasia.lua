-----------------------------------
-- ID: 5016
-- Scroll of Shining Fantasia
-- Teaches the song Shining Fantasia
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(408)
end

item_object.onItemUse = function(target)
    target:addSpell(408)
end

return item_object
