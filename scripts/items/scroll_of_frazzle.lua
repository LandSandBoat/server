-----------------------------------
-- ID: 4914
-- Scroll of Frazzle
-- Teaches the black magic Frazzle
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FRAZZLE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FRAZZLE)
end

return itemObject
