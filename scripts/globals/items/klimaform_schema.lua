-----------------------------------
-- ID: 6058
-- Klimaform Schema
-- Teaches the black magic Klimaform
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(287)
end

itemObject.onItemUse = function(target)
    target:addSpell(287)
end

return itemObject
