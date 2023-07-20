-----------------------------------
-- ID: 4990
-- Scroll of Armys Paeton V
-- Teaches the song Armys Paeton V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ARMYS_PAEON_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARMYS_PAEON_V)
end

return itemObject
