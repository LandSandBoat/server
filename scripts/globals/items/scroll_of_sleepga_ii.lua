-----------------------------------
-- ID: 4882
-- Scroll of Sleepga II
-- Teaches the black magic Sleepga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(274)
end

itemObject.onItemUse = function(target)
    target:delSpell(364)
    target:addSpell(274)
end

return itemObject
