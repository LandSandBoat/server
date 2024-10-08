-----------------------------------
-- ID: 5052
-- Scroll of Light Carol
-- Teaches the song Light Carol
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.LIGHT_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHT_CAROL)
end

return itemObject
