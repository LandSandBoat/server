-----------------------------------------
-- ID: 4779
-- Scroll of Water III
-- Teaches the black magic Water III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(171)
end

item_object.onItemUse = function(target)
    target:addSpell(171)
end

return item_object
