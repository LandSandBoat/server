-----------------------------------
-- ID: 6061
-- Item: Adloquium Schema
-- Teaches the white magic Adloquium
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(495)
end

itemObject.onItemUse = function(target)
    target:addSpell(495)
end

return itemObject
