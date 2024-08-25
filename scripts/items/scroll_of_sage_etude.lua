-----------------------------------
-- ID: 5043
-- Scroll of Sage Etude
-- Teaches the song Sage Etude
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SAGE_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SAGE_ETUDE)
end

return itemObject
