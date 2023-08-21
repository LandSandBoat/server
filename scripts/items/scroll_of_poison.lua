-----------------------------------
-- ID: 4828
-- Scroll of Poison
-- Teaches the black magic Poison
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.POISON)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.POISON)
end

return itemObject
