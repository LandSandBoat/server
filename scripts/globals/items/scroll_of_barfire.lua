-----------------------------------------
-- ID: 4668
-- Scroll of Barfire
-- Teaches the white magic Barfire
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(60)
end

item_object.onItemUse = function(target)
    target:addSpell(60)
end

return item_object
