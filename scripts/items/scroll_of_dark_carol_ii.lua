-----------------------------------
-- ID: 5061
-- Scroll of Dark Carol II
-- Teaches the song Dark Carol II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DARK_CAROL_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DARK_CAROL_II)
end

return itemObject
