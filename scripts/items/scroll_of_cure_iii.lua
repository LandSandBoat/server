-----------------------------------
-- ID: 4611
-- Scroll of Cure III
-- Teaches the white magic Cure III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURE_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURE_III)
end

return itemObject
