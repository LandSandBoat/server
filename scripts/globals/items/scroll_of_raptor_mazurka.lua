-----------------------------------------
-- ID: 5075
-- Scroll of Raptor Mazurka
-- Teaches the song Raptor Mazurka
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(467)
end

item_object.onItemUse = function(target)
    target:addSpell(467)
end

return item_object
