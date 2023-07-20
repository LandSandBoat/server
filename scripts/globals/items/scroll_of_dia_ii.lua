-----------------------------------
-- ID: 4632
-- Scroll of Dia II
-- Teaches the white magic Dia II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DIA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DIA_II)
end

return itemObject
