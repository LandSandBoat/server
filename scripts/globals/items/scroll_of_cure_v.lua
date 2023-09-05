-----------------------------------
-- ID: 4613
-- Scroll of Cure V
-- Teaches the white magic Cure V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURE_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURE_V)
end

return itemObject
