-----------------------------------------
-- ID: 4720
-- Scroll of Flash
-- Teaches the white magic Flash
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(112)
end

item_object.onItemUse = function(target)
    target:addSpell(112)
end

return item_object
