-----------------------------------
-- ID: 6076
-- plate_of_indi-str
-- Teaches INDI-STR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_STR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_STR)
end

return itemObject
