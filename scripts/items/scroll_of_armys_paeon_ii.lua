-----------------------------------
-- ID: 4987
-- Scroll of Armys Paeton II
-- Teaches the song Armys Paeton II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ARMYS_PAEON_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARMYS_PAEON_II)
end

return itemObject
