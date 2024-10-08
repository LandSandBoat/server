-----------------------------------
-- ID: 4746
-- Scroll of Deodorize
-- Teaches the white magic Deodorize
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DEODORIZE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DEODORIZE)
end

return itemObject
