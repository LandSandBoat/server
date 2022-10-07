-----------------------------------
-- ID: 4799
-- Scroll of Stonega III
-- Teaches the black magic Stonega III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(191)
end

itemObject.onItemUse = function(target)
    target:addSpell(191)
end

return itemObject
