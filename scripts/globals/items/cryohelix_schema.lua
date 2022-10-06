-----------------------------------
-- ID: 6044
-- Cryohelix Schema
-- Teaches the black magic Cryohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(282)
end

itemObject.onItemUse = function(target)
    target:addSpell(282)
end

return itemObject
