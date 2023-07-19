-----------------------------------
-- ID: 4890
-- Scroll of Firaja
-- Teaches the black magic Firaja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRAJA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRAJA)
end

return itemObject
