-----------------------------------
-- ID: 4754
-- Scroll of Fire III
-- Teaches the black magic Fire III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(146)
end

itemObject.onItemUse = function(target)
    target:addSpell(146)
end

return itemObject
