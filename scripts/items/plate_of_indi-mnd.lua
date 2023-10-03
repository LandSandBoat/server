-----------------------------------
-- ID: 6081
-- plate_of_indi-mnd
-- Teaches INDI-MND
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_MND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_MND)
end

return itemObject
