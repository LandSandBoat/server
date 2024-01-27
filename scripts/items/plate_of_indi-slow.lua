-----------------------------------
-- ID: 6099
-- plate_of_indi-slow
-- Teaches INDI-SLOW
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_SLOW)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_SLOW)
end

return itemObject
