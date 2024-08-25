-----------------------------------
-- ID: 5029
-- Scroll of Battlefield Elegy
-- Teaches the song Battlefield Elegy
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BATTLEFIELD_ELEGY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BATTLEFIELD_ELEGY)
end

return itemObject
