-----------------------------------
-- ID: 4783
-- Scroll of Firaga II
-- Teaches the black magic Firaga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(175)
end

itemObject.onItemUse = function(target)
    target:addSpell(175)
end

return itemObject
