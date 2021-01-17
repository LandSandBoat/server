-----------------------------------------
-- ID: 4756
-- Scroll of Fire V
-- Teaches the Black magic Fire V
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(148)
end

item_object.onItemUse = function(target)
    target:addSpell(148)
end

return item_object
