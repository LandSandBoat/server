-----------------------------------------
-- ID: 5053
-- Scroll of Dark Carol
-- Teaches the song Dark Carol
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(445)
end

item_object.onItemUse = function(target)
    target:addSpell(445)
end

return item_object
