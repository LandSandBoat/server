-----------------------------------
-- ID: 4843
-- Scroll of Burn
-- Teaches the black magic Burn
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(235)
end

itemObject.onItemUse = function(target)
    target:addSpell(235)
end

return itemObject
