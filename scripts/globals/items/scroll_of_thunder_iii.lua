-----------------------------------------
-- ID: 4774
-- Scroll of Thunder III
-- Teaches the black magic Thunder III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(166)
end

item_object.onItemUse = function(target)
    target:addSpell(166)
end

return item_object
