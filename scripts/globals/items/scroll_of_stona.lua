-----------------------------------
-- ID: 4626
-- Scroll of Stona
-- Teaches the white magic Stona
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(18)
end

itemObject.onItemUse = function(target)
    target:addSpell(18)
end

return itemObject
