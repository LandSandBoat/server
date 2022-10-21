-----------------------------------
-- ID: 4746
-- Scroll of Deodorize
-- Teaches the white magic Deodorize
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(138)
end

itemObject.onItemUse = function(target)
    target:addSpell(138)
end

return itemObject
