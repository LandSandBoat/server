-----------------------------------
-- ID: 4893
-- Scroll of Stoneja
-- Teaches the black magic Stoneja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(499)
end

itemObject.onItemUse = function(target)
    target:addSpell(499)
end

return itemObject
