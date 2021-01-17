-----------------------------------------
-- ID: 6061
-- Item: Adloquium Schema
-- Teaches the white magic Adloquium
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(495)
end

item_object.onItemUse = function(target)
    target:addSpell(495)
end

return item_object
