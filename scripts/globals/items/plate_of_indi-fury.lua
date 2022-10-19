-----------------------------------------
-- ID: 6083
-- plate_of_indi-fury
-- Teaches INDI-FURY
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_FURY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FURY)
end

return itemObject
