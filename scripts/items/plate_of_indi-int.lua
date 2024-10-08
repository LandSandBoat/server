-----------------------------------
-- ID: 6080
-- plate_of_indi-int
-- Teaches INDI-INT
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.INDI_INT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_INT)
end

return itemObject
