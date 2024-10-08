-----------------------------------
-- ID: 6086
-- plate_of_indi-fend
-- Teaches INDI-FEND
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.INDI_FEND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FEND)
end

return itemObject
