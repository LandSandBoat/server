-----------------------------------------
-- ID: 4872
-- Scroll of Tractor
-- Teaches the black magic Tractor
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(264)
end

item_object.onItemUse = function(target)
    target:addSpell(264)
end

return item_object
