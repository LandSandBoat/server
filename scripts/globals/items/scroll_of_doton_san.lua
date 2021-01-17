-----------------------------------------
-- ID: 4939
-- Scroll of Doton: San
-- Teaches the ninjutsu Doton: San
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(331)
end

item_object.onItemUse = function(target)
    target:addSpell(331)
end

return item_object
