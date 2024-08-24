-----------------------------------
-- ID: 4871
-- Scroll of Escape
-- Teaches the black magic Escape
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ESCAPE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ESCAPE)
end

return itemObject
