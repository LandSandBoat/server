-----------------------------------
-- ID: 4631
-- Scroll of Dia
-- Teaches the white magic Dia
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DIA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DIA)
end

return itemObject
