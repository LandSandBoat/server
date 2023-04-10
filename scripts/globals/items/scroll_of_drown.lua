-----------------------------------
-- ID: 4848
-- Scroll of Drown
-- Teaches the black magic Drown
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(240)
end

itemObject.onItemUse = function(target)
    target:addSpell(240)
end

return itemObject
