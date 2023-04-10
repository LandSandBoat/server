-----------------------------------
-- ID: 4771
-- Scroll of Stone V
-- Teaches the black magic Stone V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(163)
end

itemObject.onItemUse = function(target)
    target:addSpell(163)
end

return itemObject
