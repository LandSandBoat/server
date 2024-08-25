-----------------------------------
-- ID: 4781
-- Scroll of Water V
-- Teaches the black magic Water V
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WATER_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_V)
end

return itemObject
