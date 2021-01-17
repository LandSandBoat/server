-----------------------------------------
-- ID: 5085
-- Scroll of Regen IV
-- Teaches the white magic Regen IV
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(477)
end

item_object.onItemUse = function(target)
    target:addSpell(477)
end

return item_object
