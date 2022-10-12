-----------------------------------
-- ID: 6046
-- Item: Anemohelix Schema
-- Teaches the black magic Anemohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(280)
end

itemObject.onItemUse = function(target)
    target:addSpell(280)
end

return itemObject
