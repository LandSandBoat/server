-----------------------------------
-- ID: 4844
-- Scroll of Frost
-- Teaches the black magic Frost
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FROST)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FROST)
end

return itemObject
