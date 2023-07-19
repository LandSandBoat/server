-----------------------------------
-- ID: 4915
-- Scroll of Frazzle II
-- Teaches the black magic Frazzle II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FRAZZLE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FRAZZLE_II)
end

return itemObject
