-----------------------------------
-- ID: 4608
-- Scroll of Cure (Exclusive)
-- Teaches the white magic Cure
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURE)
end

return itemObject
