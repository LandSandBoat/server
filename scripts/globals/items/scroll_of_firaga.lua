-----------------------------------------
-- ID: 4782
-- Scroll of Firaga
-- Teaches the black magic Firaga
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(174)
end

item_object.onItemUse = function(target)
    target:addSpell(174)
end

return item_object
