-----------------------------------------
-- ID: 4936
-- Scroll of Huton: San
-- Teaches the ninjutsu Huton: San
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(328)
end

item_object.onItemUse = function(target)
    target:addSpell(328)
end

return item_object
