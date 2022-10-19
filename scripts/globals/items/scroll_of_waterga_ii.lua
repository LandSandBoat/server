-----------------------------------
-- ID: 4808
-- Scroll of Waterga II
-- Teaches the black magic Waterga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(200)
end

itemObject.onItemUse = function(target)
    target:addSpell(200)
end

return itemObject
