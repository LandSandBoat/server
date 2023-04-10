-----------------------------------
-- ID: 4816
-- Scroll of Tornado
-- Teaches the black magic Tornado
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(208)
end

itemObject.onItemUse = function(target)
    target:addSpell(208)
end

return itemObject
