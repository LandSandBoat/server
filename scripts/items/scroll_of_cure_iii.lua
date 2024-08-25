-----------------------------------
-- ID: 4611
-- Scroll of Cure III
-- Teaches the white magic Cure III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.CURE_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURE_III)
end

return itemObject
