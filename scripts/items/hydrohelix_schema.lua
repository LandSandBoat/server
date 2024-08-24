-----------------------------------
-- ID: 6042
-- Hydrohelix Schema
-- Teaches the black magic Hydrohelix
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.HYDROHELIX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HYDROHELIX)
end

return itemObject
