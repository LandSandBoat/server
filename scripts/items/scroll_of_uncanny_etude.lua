-----------------------------------
-- ID: 5040
-- Scroll of Uncanny Etude
-- Teaches the song Uncanny Etude
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.UNCANNY_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.UNCANNY_ETUDE)
end

return itemObject
