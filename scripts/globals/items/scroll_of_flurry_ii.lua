-----------------------------------
-- ID: 5105
-- Scroll of Flurry II
-- Teaches the white magic Flurry II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(846)
end

itemObject.onItemUse = function(target)
    target:addSpell(846)
end

return itemObject
