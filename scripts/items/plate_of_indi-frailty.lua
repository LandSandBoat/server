-----------------------------------
-- ID: 6092
-- plate_of_indi-frailty
-- Teaches INDI-FRAILTY
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_FRAILTY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FRAILTY)
end

return itemObject
