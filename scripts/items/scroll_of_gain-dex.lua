-----------------------------------
-- ID: 5088
-- Scroll of Gain-DEX
-- Teaches the white magic Gain-DEX
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.GAIN_DEX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GAIN_DEX)
end

return itemObject
