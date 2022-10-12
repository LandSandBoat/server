-----------------------------------
-- ID: 4856
-- Scroll of Aspir II
-- Teaches the black magic Aspir II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(248)
end

itemObject.onItemUse = function(target)
    target:addSpell(248)
end

return itemObject
