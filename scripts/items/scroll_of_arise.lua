-----------------------------------
-- ID: 5101
-- Scroll of Arise
-- Teaches the white magic Arise
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ARISE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARISE)
end

return itemObject
