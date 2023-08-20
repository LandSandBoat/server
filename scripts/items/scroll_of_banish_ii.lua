-----------------------------------
-- ID: 4637
-- Scroll of Banish II
-- Teaches the white magic Banish II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BANISH_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BANISH_II)
end

return itemObject
