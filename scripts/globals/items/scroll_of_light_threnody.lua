-----------------------------------------
-- ID: 5068
-- Scroll of Light Threnody
-- Teaches the song Light Threnody
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(460)
end

item_object.onItemUse = function(target)
    target:addSpell(460)
end

return item_object
