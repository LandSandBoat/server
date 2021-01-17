-----------------------------------------
-- ID: 4730
-- Scroll of Teleport-Holla
-- Teaches the white magic Teleport-Holla
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(122)
end

item_object.onItemUse = function(target)
    target:addSpell(122)
end

return item_object
