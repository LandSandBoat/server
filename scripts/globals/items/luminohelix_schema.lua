-----------------------------------
-- ID: 6047
-- Luminohelix Schema
-- Teaches the black magic Luminohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(285)
end

itemObject.onItemUse = function(target)
    target:addSpell(285)
end

return itemObject
