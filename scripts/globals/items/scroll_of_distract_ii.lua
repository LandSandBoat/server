-----------------------------------
-- ID: 4913
-- Scroll of Distract
-- Teaches the black magic Distract II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DISTRACT_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DISTRACT_II)
end

return itemObject
