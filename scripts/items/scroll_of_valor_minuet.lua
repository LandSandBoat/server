-----------------------------------
-- ID: 5002
-- Scroll of Valor Minuet
-- Teaches the song Valor Minuet
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.VALOR_MINUET)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.VALOR_MINUET)
end

return itemObject
