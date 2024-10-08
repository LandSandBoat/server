-----------------------------------
-- ID: 6088
-- plate_of_indi-voidance
-- Teaches INDI-VOIDANCE
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.INDI_VOIDANCE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_VOIDANCE)
end

return itemObject
