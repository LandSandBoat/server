-----------------------------------
-- ID: 4875
-- Scroll of Absorb-DEX
-- Teaches the black magic Absorb-DEX
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(267)
end

itemObject.onItemUse = function(target)
    target:addSpell(267)
end

return itemObject
