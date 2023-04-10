-----------------------------------
-- ID: 6048
-- Noctohelix Schema
-- Teaches the black magic Noctohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(284)
end

itemObject.onItemUse = function(target)
    target:addSpell(284)
end

return itemObject
