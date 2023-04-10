-----------------------------------
-- ID: 4691
-- Scroll of Baramnesra
-- Teaches the white magic Baramnesra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(85)
end

itemObject.onItemUse = function(target)
    target:addSpell(85)
end

return itemObject
