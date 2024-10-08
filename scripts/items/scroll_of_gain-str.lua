-----------------------------------
-- ID: 5087
-- Scroll of Gain-STR
-- Teaches the white magic Gain-STR
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.GAIN_STR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GAIN_STR)
end

return itemObject
