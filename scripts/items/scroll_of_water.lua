-----------------------------------
-- ID: 4777
-- Scroll of Water
-- Teaches the black magic Water
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WATER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER)
end

return itemObject
