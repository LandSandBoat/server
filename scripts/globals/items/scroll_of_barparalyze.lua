-----------------------------------
-- ID: 4682
-- Scroll of Barparalyze
-- Teaches the white magic Barparalyze
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(74)
end

itemObject.onItemUse = function(target)
    target:addSpell(74)
end

return itemObject
