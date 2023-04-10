-----------------------------------
-- ID: 4874
-- Scroll of Absorb-STR
-- Teaches the black magic Absorb-STR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(266)
end

itemObject.onItemUse = function(target)
    target:addSpell(266)
end

return itemObject
