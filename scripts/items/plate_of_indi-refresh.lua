-----------------------------------
-- ID: 6075
-- plate_of_indi-refresh
-- Teaches INDI-REFRESH
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.INDI_REFRESH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_REFRESH)
end

return itemObject
