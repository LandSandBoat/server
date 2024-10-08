-----------------------------------
-- ID: 4664
-- Scroll of Slow
-- Teaches the white magic Slow
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SLOW)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SLOW)
end

return itemObject
