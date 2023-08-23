-----------------------------------
-- ID: 4803
-- Scroll of Thundaga II
-- Teaches the black magic Thundaga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDAGA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDAGA_II)
end

return itemObject
