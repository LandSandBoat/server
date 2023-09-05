-----------------------------------
-- ID: 4848
-- Scroll of Drown
-- Teaches the black magic Drown
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DROWN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DROWN)
end

return itemObject
