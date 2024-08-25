-----------------------------------
-- ID: 4990
-- Scroll of Armys Paeton V
-- Teaches the song Armys Paeton V
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ARMYS_PAEON_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARMYS_PAEON_V)
end

return itemObject
