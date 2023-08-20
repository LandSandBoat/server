-----------------------------------
-- ID: 4829
-- Scroll of Poison II
-- Teaches the black magic Poison II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.POISON_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.POISON_II)
end

return itemObject
