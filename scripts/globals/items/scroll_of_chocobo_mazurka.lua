-----------------------------------------
-- ID: 5073
-- Scroll of Chocobo Mazurka
-- Teaches the song Chocobo Mazurka
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(465)
end

item_object.onItemUse = function(target)
    target:addSpell(465)
end

return item_object
