-----------------------------------------
-- ID: 6055
-- Item: Aurorastorm Schema
-- Teaches the white magic Aurorastorm
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(119)
end

item_object.onItemUse = function(target)
    target:addSpell(119)
end

return item_object
