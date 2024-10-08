-----------------------------------
-- ID: 4609
-- Scroll of Cure
-- Teaches the white magic Cure
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.CURE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURE)
end

return itemObject
