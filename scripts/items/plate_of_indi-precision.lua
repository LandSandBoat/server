-----------------------------------
-- ID: 6087
-- plate_of_indi-precision
-- Teaches INDI-PRECISION
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.INDI_PRECISION)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_PRECISION)
end

return itemObject
