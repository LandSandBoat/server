-----------------------------------
-- ID: 4707
-- Scroll of Endark
-- Teaches the white magic Endark
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ENDARK)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENDARK)
end

return itemObject
