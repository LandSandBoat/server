-----------------------------------
-- ID: 4799
-- Scroll of Stonega III
-- Teaches the black magic Stonega III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(191)
end

item_object.onItemUse = function(target)
    target:addSpell(191)
end

return item_object
