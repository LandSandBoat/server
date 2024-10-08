-----------------------------------
-- ID: 4780
-- Scroll of Water IV
-- Teaches the black magic Water IV
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WATER_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_IV)
end

return itemObject
