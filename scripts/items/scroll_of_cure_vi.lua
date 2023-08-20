-----------------------------------
-- ID: 4614
-- Scroll of Cure VI
-- Teaches the white magic Cure VI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURE_VI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURE_VI)
end

return itemObject
