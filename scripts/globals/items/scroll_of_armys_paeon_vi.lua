-----------------------------------
-- ID: 4991
-- Scroll of Armys Paeton VI
-- Teaches the song Armys Paeton VI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ARMYS_PAEON_VI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARMYS_PAEON_VI)
end

return itemObject
