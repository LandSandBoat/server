-----------------------------------
-- ID: 4606
-- Scroll of Dia (Exclusive)
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
