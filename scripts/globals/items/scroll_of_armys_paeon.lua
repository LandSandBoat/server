-----------------------------------
-- ID: 4986
-- Scroll of Armys Paeton
-- Teaches the song Armys Paeton
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ARMYS_PAEON)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARMYS_PAEON)
end

return itemObject
