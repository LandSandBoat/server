-----------------------------------------
-- ID: 4607, 4767
-- Scroll of Stone
-- Teaches the black magic Stone
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(159)
end

item_object.onItemUse = function(target)
    target:addSpell(159)
end

return item_object
