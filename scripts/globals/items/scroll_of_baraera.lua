-----------------------------------------
-- ID: 4676
-- Scroll of Baraera
-- Teaches the white magic Baraera
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(68)
end

item_object.onItemUse = function(target)
    target:addSpell(68)
end

return item_object
