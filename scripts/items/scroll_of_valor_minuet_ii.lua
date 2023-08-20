-----------------------------------
-- ID: 5003
-- Scroll of Valor Minuet II
-- Teaches the song Valor Minuet II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.VALOR_MINUET_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.VALOR_MINUET_II)
end

return itemObject
