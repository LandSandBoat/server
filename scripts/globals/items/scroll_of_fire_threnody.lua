-----------------------------------------
-- ID: 5062
-- Scroll of Fire Threnody
-- Teaches the song Fire Threnody
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(454)
end

item_object.onItemUse = function(target)
    target:addSpell(454)
end

return item_object
