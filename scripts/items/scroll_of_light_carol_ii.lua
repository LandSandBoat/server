-----------------------------------
-- ID: 5060
-- Scroll of Light Carol II
-- Teaches the song Light Carol II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.LIGHT_CAROL_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHT_CAROL_II)
end

return itemObject
