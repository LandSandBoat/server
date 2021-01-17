-----------------------------------------
-- ID: 4945
-- Scroll of Suiton: San
-- Teaches the ninjutsu Suiton: San
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(337)
end

item_object.onItemUse = function(target)
    target:addSpell(337)
end

return item_object
