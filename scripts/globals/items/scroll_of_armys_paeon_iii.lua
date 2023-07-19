-----------------------------------
-- ID: 4988
-- Scroll of Armys Paeton III
-- Teaches the song Armys Paeton III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ARMYS_PAEON_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARMYS_PAEON_III)
end

return itemObject
