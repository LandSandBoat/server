-----------------------------------------
-- ID: 5069
-- Scroll of Dark Threnody
-- Teaches the song Dark Threnody
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(461)
end

item_object.onItemUse = function(target)
    target:addSpell(461)
end

return item_object
