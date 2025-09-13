-----------------------------------
-- ID: 5055
-- Scroll of Ice Carol II
-- Teaches the song Ice Carol II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ICE_CAROL_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ICE_CAROL_II)
end

return itemObject
