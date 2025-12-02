-----------------------------------
-- ID: 5058
-- Scroll of Lightning Carol II
-- Teaches the song Lightning Carol II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.LIGHTNING_CAROL_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHTNING_CAROL_II)
end

return itemObject
