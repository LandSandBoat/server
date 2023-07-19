-----------------------------------
-- ID: 4612
-- Scroll of Cure IV
-- Teaches the white magic Cure IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURE_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURE_IV)
end

return itemObject
