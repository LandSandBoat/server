-----------------------------------
-- ID: 4682
-- Scroll of Barparalyze
-- Teaches the white magic Barparalyze
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARPARALYZE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARPARALYZE)
end

return itemObject
