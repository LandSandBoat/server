-----------------------------------
-- ID: 4610
-- Scroll of Cure II
-- Teaches the white magic Cure II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURE_II)
end

return itemObject
