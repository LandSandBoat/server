-----------------------------------
-- ID: 4681
-- Scroll of Barpoison
-- Teaches the white magic Barpoison
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARPOISON)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARPOISON)
end

return itemObject
