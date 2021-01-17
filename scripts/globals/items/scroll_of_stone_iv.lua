-----------------------------------------
-- ID: 4770
-- Scroll of Stone IV
-- Teaches the black magic Stone IV
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(162)
end

item_object.onItemUse = function(target)
    target:addSpell(162)
end

return item_object
