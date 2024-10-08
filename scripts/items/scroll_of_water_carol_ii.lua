-----------------------------------
-- ID: 5059
-- Scroll of Water Carol II
-- Teaches the song Water Carol II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WATER_CAROL_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_CAROL_II)
end

return itemObject
