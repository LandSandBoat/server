-----------------------------------
-- ID: 5008
-- Scroll of Blade Madrigal
-- Teaches the song Blade Madrigal
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BLADE_MADRIGAL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLADE_MADRIGAL)
end

return itemObject
