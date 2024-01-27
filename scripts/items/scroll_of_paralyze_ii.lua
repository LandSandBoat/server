-----------------------------------
-- ID: 6570
-- Scroll of Paralyze II
-- Teaches the white magic Paralyze II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PARALYZE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PARALYZE_II)
end

return itemObject
