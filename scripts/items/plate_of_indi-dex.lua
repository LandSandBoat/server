-----------------------------------
-- ID: 6077
-- plate_of_indi-dex
-- Teaches INDI-DEX
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.INDI_DEX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_DEX)
end

return itemObject
