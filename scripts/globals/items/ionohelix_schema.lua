-----------------------------------
-- ID: 6043
-- Ionohelix Schema
-- Teaches the black magic Ionohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(283)
end

itemObject.onItemUse = function(target)
    target:addSpell(283)
end

return itemObject
