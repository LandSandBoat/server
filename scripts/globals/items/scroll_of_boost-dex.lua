-----------------------------------
-- ID: 5095
-- Scroll of Boost-DEX
-- Teaches the white magic Boost-DEX
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(480)
end

itemObject.onItemUse = function(target)
    target:addSpell(480)
end

return itemObject
