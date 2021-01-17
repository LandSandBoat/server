-----------------------------------------
-- ID: 5067
-- Scroll of Water Threnody
-- Teaches the song Water Threnody
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(459)
end

item_object.onItemUse = function(target)
    target:addSpell(459)
end

return item_object
