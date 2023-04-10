-----------------------------------
-- ID: 6041
-- Pyrohelix Schema
-- Teaches the black magic Pyrohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(281)
end

itemObject.onItemUse = function(target)
    target:addSpell(281)
end

return itemObject
