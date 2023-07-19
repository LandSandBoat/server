-----------------------------------
-- ID: 4989
-- Scroll of Armys Paeton IV
-- Teaches the song Armys Paeton IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ARMYS_PAEON_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARMYS_PAEON_IV)
end

return itemObject
