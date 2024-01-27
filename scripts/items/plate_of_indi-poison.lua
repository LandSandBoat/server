-----------------------------------
-- ID: 6074
-- plate_of_indi-poison
-- Teaches INDI-POISON
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_POISON)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_POISON)
end

return itemObject
