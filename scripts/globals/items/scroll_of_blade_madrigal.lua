-----------------------------------------
-- ID: 5008
-- Scroll of Blade Madrigal
-- Teaches the song Blade Madrigal
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(400)
end

item_object.onItemUse = function(target)
    target:addSpell(400)
end

return item_object
