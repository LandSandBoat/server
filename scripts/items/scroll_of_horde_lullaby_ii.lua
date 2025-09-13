-----------------------------------
-- ID: 4985
-- Scroll of Horde Lullaby II
-- Teaches the song Horde Lullaby II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.HORDE_LULLABY_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HORDE_LULLABY_II)
end

return itemObject
