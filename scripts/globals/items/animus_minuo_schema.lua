-----------------------------------
-- ID: 6060
-- Item: Animus Minuo Schema
-- Teaches the white magic Animus Minuo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(309)
end

itemObject.onItemUse = function(target)
    target:addSpell(309)
end

return itemObject
