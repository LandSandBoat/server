-----------------------------------
-- ID: 4727
-- Scroll of Enwater II
-- Teaches the white magic Enwater II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(317)
end

itemObject.onItemUse = function(target)
    target:addSpell(317)
end

return itemObject
