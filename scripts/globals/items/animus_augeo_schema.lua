-----------------------------------
-- ID: 6059
-- Item: Animus Augeo Schema
-- Teaches the white magic Animus Augeo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(308)
end

itemObject.onItemUse = function(target)
    target:addSpell(308)
end

return itemObject
