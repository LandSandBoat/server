-----------------------------------------
-- ID: 4627
-- Scroll of Viruna
-- Teaches the white magic Viruna
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(19)
end

item_object.onItemUse = function(target)
    target:addSpell(19)
end

return item_object
