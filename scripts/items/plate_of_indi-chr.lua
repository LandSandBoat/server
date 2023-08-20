-----------------------------------------
-- ID: 6082
-- plate_of_indi-chr
-- Teaches INDI-CHR
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_CHR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_CHR)
end

return itemObject
