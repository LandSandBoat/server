-----------------------------------
-- ID: 6042
-- Hydrohelix Schema
-- Teaches the black magic Hydrohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(279)
end

itemObject.onItemUse = function(target)
    target:addSpell(279)
end

return itemObject
