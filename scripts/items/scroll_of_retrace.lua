-----------------------------------
-- ID: 4873
-- Scroll of Retrace
-- Teaches the black magic Retrace
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RETRACE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RETRACE)
end

return itemObject
