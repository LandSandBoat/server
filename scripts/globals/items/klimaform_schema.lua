-----------------------------------
-- ID: 6058
-- Klimaform Schema
-- Teaches the black magic Klimaform
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(287)
end

item_object.onItemUse = function(target)
    target:addSpell(287)
end

return item_object
