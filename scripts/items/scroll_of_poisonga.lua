-----------------------------------
-- ID: 4833
-- Scroll of Poisonga
-- Teaches the black magic Poisonga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.POISONGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.POISONGA)
end

return itemObject
