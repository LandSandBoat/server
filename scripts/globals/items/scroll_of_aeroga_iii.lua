-----------------------------------
-- ID: 4794
-- Scroll of Aeroga III
-- Teaches the black magic Aeroga III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(186)
end

itemObject.onItemUse = function(target)
    target:addSpell(186)
end

return itemObject
