-----------------------------------
-- ID: 4815
-- Scroll of Freeze II
-- Teaches the black magic Freeze II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(207)
end

itemObject.onItemUse = function(target)
    target:addSpell(207)
end

return itemObject
